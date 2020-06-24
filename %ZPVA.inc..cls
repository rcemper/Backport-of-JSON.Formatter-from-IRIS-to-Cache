#;%ZPVA ;backport to Caché by RCC 2020 for Developer Community
	;
	; Copyright (c) 2019 by InterSystems Corporation.
	; Cambridge, Massachusetts, U.S.A.  All rights reserved.
	; Confidential property of InterSystems Corporation.
	;
#; Definitions for Packed Vectors (PV) and Packed Vector Arrays (PVA)
#;
#; Define the PV_IDTYPE_x of PV as found in the header of the PV
#;
#; PV is a %DynamicArray
#define	PVTYPEARRAY	     157         
#; PV is a %DynamicObject (with its own keymap)
#define PVTYPEOBJECT         158
#; PV is a %DynamicString
#define PVTYPECHAR	     159
#; PV is a %DynamicBinary
#define PVTYPEBINARY	     160
#; PV is a %Stream.Dynamic{Character,Binary}
#define PVTYPESTREAM	     161
#;
#; PV_Bufxxx type codes
#;
#; Buffer contains Characters
#define PVBUFCHAR	1
#; Buffer contains 8-bit bytes
#define PVBUFBYTE	2
#; Buffer contains 8-bit bytes (to be converted to Base64 when fetched)
#define PVBUFBASE64	3
#;
#; Define the PV_VALUE_x, types of values, found inside a PV as returned
#; by $gettypeof()
#;
#; String is null
#define PVVALUENULL          0
#; String is true
#define PVVALUETRUE          1
#; String is false
#define PVVALUEFALSE         2
#; 32-bit positive integer
#define PVVALUEINTEGERPOS    3
#; 32-bit negative integer
#define PVVALUEINTEGERNEG    4
#; Unused code
#define PVVALUEUNUSED1       5
#; This is meta-data for an array
#define PVVALUEARRAY         6
#; This is meta-data for an object
#define PVVALUEOBJECT        7
#; Normal text string
#define PVVALUETEXT          8
#; Numeric number
#define PVVALUENUMBER        9
#; Text overflow 
#define	PVVALUEOVERFLOW	     10
#; Cache floating point, 64 bit mantissa, 8 bits for sign and exponent
#define PVVALUECACHENUMERIC  11
#; An embedded Cache object, maybe another %Object or %Array
#define PVVALUEOREF          12
#; The value is unassigned
#define	PVVALUEUNASSIGNED    13
#; Long 64 bit, positive
#define PVVALUELONGPOS       14
#; Long 64 bit, negative
#define PVVALUELONGNEG       15
#; A byte[] array.
#define PVVALUEBYTE          16
#; Date/Time object
#define PVVALUEDATETIME      17
#; Double precision floating point in binary
#define PVVALUEDOUBLE        18
#; Single precision floating point in binary
#define PVVALUESINGLE        19
#; UTF-8 Bytes, in serialised format only
#define PVVALUEUTF8          20
#; Nested array or object, in serialised format only
#define PVVALUENESTED        21
#; End of data during $getNext()
#define	PVVALUEEOF	     31
#;
#; Find out the type of value. 
#; One of the following strings are returned.
#;   "null"                  - JSON null
#;   "boolean"               - Either "true" or "false"
#;   "number"                - Any numeric value
#;   "oref"                  - A reference to another Cache object
#;   "object"                - A nested object
#;   "array"                 - A nested array 
#;   "string"                - Normal text string
#;   "unassigned"            - The value is unassigned
#; 
#define JSONGetTypeOf(%object,%key) $CASE(%object.%GetTypeCodeOf(%key),$$$PVVALUENULL:"null",$$$PVVALUETRUE:"boolean",$$$PVVALUEFALSE:"boolean",$$$PVVALUEINTEGERPOS:"number",$$$PVVALUEINTEGERNEG:"number",$$$PVVALUEARRAY:"array",$$$PVVALUEOBJECT:"object",$$$PVVALUETEXT:"string",$$$PVVALUENUMBER:"number",$$$PVVALUEOVERFLOW:"illegalvalue",$$$PVVALUECACHENUMERIC:"number",$$$PVVALUEOREF:"oref",$$$PVVALUEUNASSIGNED:"unassigned",$$$PVVALUELONGPOS:"number",$$$PVVALUELONGNEG:"number",$$$PVVALUEBYTE:"string",$$$PVVALUEDOUBLE:"number",$$$PVVALUESINGLE:"number",$$$PVVALUEUTF8:"string",$$$PVVALUEEOF:"unassigned",:"UNKNOWN")
#;
#;
#; These are the error codes that can be returned with %FromJSON()
#;
#; Parsing okay
#define JSONERROROKAY					1
#; Source wasn't a string
#define JSONERRORNOSTRING				2
#; General parsing error on JSON string
#define JSONERRORPARSEFAIL				3
#; Internal error
#define JSONERRORINTERNALERROR				4
#; Memory allocation failure
#define JSONERRORNOMEMORY				5
#; Invalid hex in \uXXXX string
#define JSONERRORINVALIDHEX				6
#; Hex in \uXXXX string too big for 8-bit systems
#define JSONERROROVERFLOWHEX				7
#; Invalid escape sequence \X
#define JSONERRORINVALIDESCAPE				8
#; Number is too large
#define JSONERRORMAXNUMBERC				9
#; Read error from input stream
#define JSONERRORREADERROR				10
#; Exceeded the maximum depth
#define JSONERRORMAXDEPTH				11
#; EOF seen prematurely
#define JSONERRORUNEXPECTEDEOF				12
#; A duplicate key was seen in an object
#define JSONERRORDUPLICATEKEY				13
#; An error was thrown by Cache
#define JSONERRORCACHEKERNEL				14
#; The metadata is missing or illegal
#define JSONERRORMETADATA				15
#; The internal structure is corrupt
#define JSONERRORCORRUPTSTRUCTURE			16
#; Invalid arguments passed to the $zu(210)
#define JSONERRORINVALIDZUARGS				17
#; Output variable exceeded maximum size
#define JSONERRORMAXSIZE				18
#;
#;
#; $ZU(210,subcode,...) subcodes
#;
#;
#; PVSSize $ZU(210,$$$PVSSize)
#; Returns 'allocated' size of PV_Buf/PV_Stream
#;
#define PVSSize			40
#;
#; PVSReadbuf $zu(210,$$$PVSReadBuf,i%DAOPos,..#BUFLEN)
#; Returns string of length ..#BUFLEN starting at i%DAPPos in a PV_Buf;
#; Note string may be shorter if end-of-buffer is enounted.
#;
#define PVSReadBuf		41
#;
#; PVSstreamPVO $ZU(210,$$$PVSstreamPVO,DAOstring)
#; Current oref (which is an oref of the %Stream.DAOString
#; class) gets PVO of type PVO_TYPE_STREAM which references the PV_Buf of
#; oref DAOString (which is an oref of the %DynamicString class)
#;
#define PVSstreamPVO		42
#;
#; PVSstringBuf $ZU(210,$$$PVSstringBuf,size)
#; Returns an empty %DynamicString object capable of holding at least
#; 'size' characters.  This %DynamicString object is populated using
#; $ZU(210,$$$PVSWriteBuf,buf,string) method calls.
#;
#define PVSstringBuf		43
#;
#; PVSWriteBuf $ZU(210,$$$PVSWriteBuf,buf,string)
#; Appends 'string' onto end of %DynamicString 'buf' and returns the new
#; length of 'buf'.
#;
#define PVSWriteBuf		44
