# Hole Filling 

The goal is to build a small image processing library that fills holes in images, along with a small command line utility that uses that library, and answer a few questions. T

The library must support filling holes in grayscale images, where each pixel value is a float in the range [0, 1] , and hole (missing) values which are marked with the value -1 . 

The library should provide the ability to fill a hole in an 

## Objects and dependencies
<div style="text-align:center"><img src =“Objects.png” /></div>

- `Image`
- `Pixel`
- `WeightCalculator`
- `Painter`
- `HoleFiller`


## Usage

```swift
// Create objects and dependencies

let calculator = try! WeightCalculator()
let painter = Painter(calculator: calculator)
let filler = HoleFiller(painter: painter)

let image = createRandomImage(width: 8, height: 8)

/* 
 0.52079123  	  0.44774288  	0.29584396  	0.33031756  	0.52358705  	0.5988997  	0.0637241  		0.5191012
  0.6195881  	  0.80261135  	0.38083655  	0.4963147  		0.6084128  		0.76217604  	0.1850484  		0.6507384
  0.5335464  	  0.16132504  	0.16224003  	0.734828  		0.98543656  	0.031974614  	0.891737  		0.5651679
  0.4072578 	  0.29851526  	0.810727  		0.221299  		0.5039017  		0.27097684  	0.87637293  	0.43865794
  0.0037938356  0.9443677  	0.5087702  		0.7594296  	0.19049245  	0.1696651  		0.13169426  	0.19041085
  0.5803194  	 0.51569456  	0.36468363  	0.6122405 	 	0.28687966  	0.6701876  		0.0055419207   0.61656004
  0.79052687  	 0.006593287  	0.7625079  		0.8841576  		0.98396605 	0.1470384  		0.58012176  	0.7705687
  0.1391741  		 0.88426757  	0.9003094  	0.57886577  	0.20016009  	0.76112884  	0.1872667  		0.31389517
*/ 

// Add holes to random image
let imageWithHoles = filler.addHoles(to: image)

/*
 0.52079123  	0.44774288  	0.29584396  	0.33031756  	0.52358705  	0.5988997  	0.0637241  		0.5191012
  0.6195881  	0.80261135  	0.38083655  	0.4963147  		0.6084128  		0.76217604  	0.1850484  		0.6507384
  0.5335464  	0.16132504  	-1  				-1  				-1  				-1  				0.891737  		0.5651679
  0.4072578 	 0.29851526  	-1  				-1  				-1  				-1  				0.87637293  	0.43865794
  0.0037938356  0.9443677  	-1  				-1  				-1  				-1  				0.13169426  	0.19041085
  0.5803194  	0.51569456  	-1  				-1 	 			-1  				-1  				0.0055419207   0.61656004
  0.79052687  	0.006593287  	0.7625079  		0.8841576  		0.98396605 	0.1470384  		0.58012176  	0.7705687
  0.1391741  		0.88426757  	0.9003094  	0.57886577  	0.20016009  	0.76112884  	0.1872667  		0.31389517
*/

// Fill holes 
let imageWithFilledHoles = filler.fillHoles(in: imageWithHoles)

/*
  0.52079123  	  0.44774288  	0.29584396  	0.33031756  	0.52358705  	0.5988997  	0.0637241  		 0.5191012
  0.6195881  	  0.80261135  	0.38083655  	0.4963147  		0.6084128  		0.76217604  	0.1850484  		 0.6507384
  0.5335464 	  0.16132504  	0.4447592  	0.51530206 	0.5725758  		0.6361056  		0.891737  		 0.5651679
  0.4072578  	  0.29851526  	0.48475963  	0.5296334  	0.54886395  	0.5929656  	0.87637293  	 0.43865794
  0.0037938356  0.9443677  	0.59990907  	0.56733394  	0.5343675  		0.43001387  	0.13169426 	 0.19041085
  0.5803194  	  0.51569456  	0.593295  		0.6601697  		0.6107619  		0.38261762  	0.0055419207   0.61656004
  0.79052687  	 0.006593287  	0.7625079  		0.8841576  		0.98396605  	0.1470384  		0.58012176  	0.7705687
  0.1391741  	 	 0.88426757  	0.9003094  	0.57886577  	0.20016009  	0.76112884  	0.1872667  		0.31389517
*/
```
