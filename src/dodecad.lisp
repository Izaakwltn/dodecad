(in-package #:dodecad)

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

(defun %encode-row (tones)
  "Encode a list of tones"
  (loop :with encoded := 0
	:for tone :in (reverse tones)
	:do (setq encoded (+ tone (ash encoded 4)))
	:finally (return encoded)))

(defun %decode-row (row)
  (loop :with decoding := row
	:until (= 12 (length decoded))
	:collect (logand decoding #b1111) :into decoded
	:do (setq decoding (ash decoding -4))
	:finally (return decoded)))

;;;
;;; Encoded Row operations
;;;

(defmacro %with-transform (out &body body)
  "Transform a row according to a function applied to "
  `(loop :with out := ,out
	 :for i :from 0 :to 44 :by 4
	 :do (setq out ,@body)
	 :finally (return out)))

(defun %transpose-raw (row degree)
  (%with-transform #x0000000000000000
    (logior (ash (mod (+ degree
			   (logand #xF (ash row (- i))))
			12)
		   i)
	      out)))

(defun %transpose-to-root (row root)
  (%transpose-raw row (- root (ldb (byte 4 0) row))))

(defun transpose (row degree)
  (%decode-row (%transpose-raw (%encode-row row) degree)))

(defun %retrograde-raw (row)
  (%with-transform #x0000000000000000
    (setq out (logior (ash (logand #xF (ash row (- i)))
			   (- 44 i))
		      out))))

(defun retrograde (row)
  (%decode-row (%retrograde-raw (%encode-row row))))

(defun %inverse-raw (row)
  (let* ((p0 (ldb (byte 4 0) row))
	 (offset (abs (- p0 (- 12 p0)))))
    (%with-transform #x0000000000000000
      (setq out (logior (ash (mod
			      (+ offset
				 (mod (- #b1100
					 (logand #xF (ash row (- i))))
				      12))
			      12)
			     i)
			out)))))

(defun inverse (row)
  (%decode-row (%inverse-raw (%encode-row row))))

(defun %matrix-raw (row)
  (let ((inverse (%inverse-raw row)))
    (%with-transform nil
      (append out (list (%transpose-to-root row (logand #xF (ash inverse (- i)))))))))

(defun matrix (row)
  (mapcar #'%decode-row
	  (%matrix-raw (%encode-row row))))

;;;
;;; Printing rows and matrices
;;;

(defun print-matrix (row &optional (stream *standard-output*))
  "Generate and print the tone row matrix for the given row."
  (dolist (r (matrix row))
    (format stream "|~{~3d |~}~%" r)))
