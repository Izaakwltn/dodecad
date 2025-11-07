(in-package #:dodecad)

(defun %valid-row-tones-p (tones)
  (= 12
     (length (intersection '(0 1 2 3 4 5 6 7 8 9 10 11) tones))))

(deftype %valid-row-tones ()
  `(satisfies %valid-row-tones-p))

(defun default-row ()
  '(0 1 2 3 4 5 6 7 8 9 10 11))

;;;
;;; Turning tone row lists '(0 1 2 3 4 5 6 7 8 9 10 11) into 64 bit integer representation
;;;
;;; <1-bit Inverse>|<1-bit Retrograde>|<4 bits root><8 bits free>|<48 bits tone-row>
;;;

(defun %encode-prefix (root inverse retrograde)
  (ash (logior (if inverse    #b10000000 #b0)
	       (if retrograde #b01000000 #b0)
	       root)
       48))

(defun %encode-row (tones &key inverse retrograde)
  "Encode a list of tones"
  (loop :with encoded := 0
	:for tone :in (reverse tones)
	:do (setq encoded (+ tone (ash encoded 4)))
	:finally (return (logior (%encode-prefix (first tones)
						 inverse
						 retrograde)
				 encoded))))

(defun %decode-row (row)
  (loop :with decoding := row
	:until (= 12 (length decoded))
	:collect (logand decoding #b1111) :into decoded
	:do (setq decoding (ash decoding -4))
	:finally (return decoded)))

;;;
;;; Prefix manipulation
;;;

(defun %flip-flag (row index)
  (dpb (mod (1+ (ldb (byte 1 index) row)) 2)
       (byte 1 index)
       row))

(defun %flip-inverse-flag (row)
  (%flip-flag row 63))

(defun %flip-retrograde-flag (row)
  (%flip-flag row 62))

;;;
;;; Encoded Row operations
;;;

(defmacro %with-transform (row &body body)
  "Transform a row according to a function applied to "
  `(let ((prefix (logand #xFFFF000000000000 ,row))
	 (tones  (logand #x0000FFFFFFFFFFFF ,row))
	 (out    #x0000000000000000))
     (loop :for i :from 0 :to 44 :by 4
	   :do ,@body
	   :finally (return (logior prefix out)))))

(defun %transpose (row degree)
  (%with-transform row
    (setq out (logior (ash (mod (+ degree
				   (logand #xF (ash tones (- i))))
					  12)
				     i)
				out))))

(defun transpose (row degree)
  (%decode-row (%transpose (%encode-row row) degree)))

(defun %retrograde (row)
  (%with-transform row
    (setq out (logior (ash (logand #xF (ash tones (- i)))
			   (- 44 i))
		      out))))

(defun retrograde (row)
  (%decode-row (%retrograde (%encode-row row))))

(defun %inverse (row)
  (%with-transform row
    (setq out (logior (ash (mod (- #b1100
				   (logand #xF (ash tones (- i))))
				12)
			   i)
		      out))))

(defun inverse (row)
  (%decode-row (%inverse (%encode-row row))))

;;;
;;; Printing rows and matrices
;;;

(defun %print-tone (tone &optional (stream nil))
  (if (= (length (format nil "~d" tone)) 1)
      (format stream "  ~d |" tone)
      (format stream " ~d |" tone)))

(defun %print-row (row &optional (stream *standard-output*))
  (format stream "|~{~a~}~%"
	  (map 'list #'print-tone
	       (etypecase row
		 (integer
		  (%decode-row row))
		 (%valid-row-tones
		  row)))))

(defun print-matrix (row &optional (stream *standard-output*))
  "Generate and print the tone row matrix for the given row."
  (let* ((p0 (first row)))
    (loop :for root :in (inverse row)
	  :do (%print-row (transpose row (mod (+ p0 root) 12)) stream))))
