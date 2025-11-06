(in-package #:dodecad)

;;;
;;; Row tones must be the set {0-11} without duplicates
;;;

(defun %valid-row-tones-p (tones)
  (= 12
     (length (intersection '(0 1 2 3 4 5 6 7 8 9 10 11) tones))))

(deftype %valid-row-tones ()
  `(satisfies %valid-row-tones-p))

(defun default-row ()
  '(0 1 2 3 4 5 6 7 8 9 10 11))

;;;
;;; Turning tone row lists '(0 1 2 3 4 5 6 7 8 9 10 11) into 48 bit integer representation
;;;
;;; Prefix: <1-bit Inverse><1-bit Retrograde><4 bits root>
;;;

(defun %encode-prefix (root inverse retrograde)
  (ash (logior (if inverse    #b10000000 #b0)
	       (if retrograde #b01000000 #b0)
	       root)
       48))

(defun encode-row (tones &key inverse retrograde)
  "Encode a list of tones"
  (loop :with encoded := 0
	:for tone :in (reverse tones)
	:do (setq encoded (+ tone (ash encoded 4)))
	:finally (return (logior (%encode-prefix (first tones)
						 inverse
						 retrograde)
				 encoded))))

(defun decode-row (row)
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

(defmacro with-split-row (row &body body)
  `(let ((prefix (logand #xFFFF000000000000 ,row))
	 (tones  (logand #x0000FFFFFFFFFFFF ,row))
	 (out    #x0000000000000000))
     ,@body))

;;;
;;; Encoded Row operations
;;;

(defun transpose (row degree)
  (with-split-row row
    (loop :for i :from 0 :to 44 :by 4
	  :do (setq out (logior (ash (mod (+ degree
					     (logand #xF (ash tones (- i))))
					  12)
				     i)
				out))
	  :finally (return (logior prefix out)))))

(defun retrograde (row)
  (with-split-row row
    (loop :for i :from 0 :to 44 :by 4
	  :do (setq out (logior (ash (logand #xF (ash tones (- i)))
				     (- 44 i))
				out))
	  :finally (return (logior prefix out)))))

(defun inverse (row)
  (with-split-row row
    (loop :for i :from 0 :to 44 :by 4
	  :do (setq out (logior (ash (mod (- #b1100
					     (logand #xF (ash tones (- i))))
					  12)
				     i)
				out))
	  :finally (return (logior prefix out)))))

;;;
;;; Printing rows and matrices
;;;

(defun print-tone (tone &optional (stream nil))
  (if (= (length (format nil "~d" tone)) 1)
      (format stream "  ~d |" tone)
      (format stream " ~d |" tone)))

(defun print-row (row &optional (stream *standard-output*))
  (format stream "|~{~a~}~%"
	  (map 'list #'print-tone
	       (etypecase row
		 (integer
		  (decode-row row))
		 (%valid-row-tones
		  row)))))

(defun print-matrix (row &optional (stream *standard-output*))
  "Generate and print the tone row matrix for the given row."
  (let* ((p0 (first row)))
    (loop :for root :in (decode-row (inverse (encode-row row)))
	  :do (print-row (transpose (encode-row row) (mod (+ p0 root) 12)) stream))))
