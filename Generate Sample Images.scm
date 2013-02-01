(define (script-fu-generate-sample-images)
	(define width 640)
	(define height 400)
	(do ((i 1 (+ i 1))) ((> i 10))
		(define text (number->string i))
		(create-text-image text width height)
	)
)

(define (create-text-image text width height)

	(define file-extension ".jpg")
	(define file-name (string-append text file-extension))
	(define quality 0.8)
	
	(define image (car(gimp-image-new width height RGB)))
	(define background-layer (car(gimp-layer-new image width height RGB-IMAGE "Background" 100  NORMAL-MODE)))
	(define text-layer (car(gimp-text-layer-new image text "Sans" 32 PIXELS)))

	(gimp-drawable-fill background-layer WHITE-FILL)
	(gimp-image-insert-layer image background-layer 0 0)
	(gimp-image-insert-layer image text-layer 0 0)
	(define merged-layer (car(gimp-image-merge-visible-layers image CLIP-TO-IMAGE)))
	(file-jpeg-save RUN-NONINTERACTIVE image merged-layer file-name file-name quality 0 1 0 "" 0 1 0 2)

)

(script-fu-register
	"script-fu-generate-sample-images"
	"<Image>/File/Create/Sample Images"
	"Generate sample images for testing."
	"Robin Grindrod"
	""
	"January 2013"
	""
)
