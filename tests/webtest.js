/* Generated by the Nim Compiler v0.15.0 */
/*   (c) 2016 Andreas Rumpf */

var framePtr = null;
var excHandler = 0;
var lastJSError = null;
if (typeof Int8Array === 'undefined') Int8Array = Array;
if (typeof Int16Array === 'undefined') Int16Array = Array;
if (typeof Int32Array === 'undefined') Int32Array = Array;
if (typeof Uint8Array === 'undefined') Uint8Array = Array;
if (typeof Uint16Array === 'undefined') Uint16Array = Array;
if (typeof Uint32Array === 'undefined') Uint32Array = Array;
if (typeof Float32Array === 'undefined') Float32Array = Array;
if (typeof Float64Array === 'undefined') Float64Array = Array;
var NTI3444 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI124 = {size: 0,kind: 36,base: null,node: null,finalizer: null};
var NTI54365 = {size: 0,kind: 16,base: null,node: null,finalizer: null};
var NTI54364 = {size: 0,kind: 22,base: null,node: null,finalizer: null};
var NTI54348 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI128 = {size: 0,kind: 36,base: null,node: null,finalizer: null};
var NTI54282 = {size: 0,kind: 16,base: null,node: null,finalizer: null};
var NTI3456 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3452 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3438 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI104 = {size: 0,kind: 31,base: null,node: null,finalizer: null};
var NTI12409 = {size: 0, kind: 18, base: null, node: null, finalizer: null};
var NTI3408 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI138 = {size: 0,kind: 28,base: null,node: null,finalizer: null};
var NTI140 = {size: 0,kind: 29,base: null,node: null,finalizer: null};
var NTI3485 = {size: 0,kind: 22,base: null,node: null,finalizer: null};
var NTI3424 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3436 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3440 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NNI3440 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3440.node = NNI3440;
var NNI3436 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3436.node = NNI3436;
NTI3485.base = NTI3424;
var NNI3424 = {kind: 2, len: 4, offset: 0, typ: null, name: null, sons: [{kind: 1, offset: "parent", len: 0, typ: NTI3485, name: "parent", sons: null}, 
{kind: 1, offset: "name", len: 0, typ: NTI140, name: "name", sons: null}, 
{kind: 1, offset: "message", len: 0, typ: NTI138, name: "msg", sons: null}, 
{kind: 1, offset: "trace", len: 0, typ: NTI138, name: "trace", sons: null}]};
NTI3424.node = NNI3424;
var NNI3408 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3408.node = NNI3408;
NTI3424.base = NTI3408;
NTI3436.base = NTI3424;
NTI3440.base = NTI3436;
var NNI12409 = {kind: 2, len: 2, offset: 0, typ: null, name: null, sons: [{kind: 1, offset: "Field0", len: 0, typ: NTI140, name: "Field0", sons: null}, 
{kind: 1, offset: "Field1", len: 0, typ: NTI104, name: "Field1", sons: null}]};
NTI12409.node = NNI12409;
var NNI3438 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3438.node = NNI3438;
NTI3438.base = NTI3436;
var NNI3452 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3452.node = NNI3452;
NTI3452.base = NTI3424;
var NNI3456 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3456.node = NNI3456;
NTI3456.base = NTI3424;
NTI54282.base = NTI128;
NTI54365.base = NTI124;
NTI54364.base = NTI54365;
var NNI54348 = {kind: 1, offset: "data", len: 0, typ: NTI54364, name: "data", sons: null};
NTI54348.node = NNI54348;
var NNI3444 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3444.node = NNI3444;
NTI3444.base = NTI3424;
function makeNimstrLit(c_13403) {

    var ln = c_13403.length;
    var result = new Array(ln + 1);
    var i = 0;
    for (; i < ln; ++i) {
      result[i] = c_13403.charCodeAt(i);
    }
    result[i] = 0; // terminating zero
    return result;
    }
function SetConstr() {

      var result = {};
      for (var i = 0; i < arguments.length; ++i) {
        var x = arguments[i];
        if (typeof(x) == "object") {
          for (var j = x[0]; j <= x[1]; ++j) {
            result[j] = true;
          }
        } else {
          result[x] = true;
        }
      }
      return result;
    }
function nimCopy(dest_18515, src_18516, ti_18517) {

var result_18829 = null;
switch (ti_18517.kind) {
case 21: case 22: case 23: case 5: if (!(isfatpointer_18498(ti_18517))) {
result_18829 = src_18516;
}
else {
result_18829 = [src_18516[0], src_18516[1]];}


break;
case 19:       if (dest_18515 === null || dest_18515 === undefined) {
        dest_18515 = {};
      }
      else {
        for (var key in dest_18515) { delete dest_18515[key]; }
      }
      for (var key in src_18516) { dest_18515[key] = src_18516[key]; }
      result_18829 = dest_18515;
    
break;
case 18: case 17: if (!((ti_18517.base == null))) {
result_18829 = nimCopy(dest_18515, src_18516, ti_18517.base);
}
else {
if ((ti_18517.kind == 17)) {
result_18829 = (dest_18515 === null || dest_18515 === undefined) ? {m_type: ti_18517} : dest_18515;}
else {
result_18829 = (dest_18515 === null || dest_18515 === undefined) ? {} : dest_18515;}
}
nimCopyAux(result_18829, src_18516, ti_18517.node);

break;
case 24: case 4: case 27: case 16:       if (src_18516 === null) {
        result_18829 = null;
      }
      else {
        if (dest_18515 === null || dest_18515 === undefined) {
          dest_18515 = new Array(src_18516.length);
        }
        else {
          dest_18515.length = src_18516.length;
        }
        result_18829 = dest_18515;
        for (var i = 0; i < src_18516.length; ++i) {
          result_18829[i] = nimCopy(result_18829[i], src_18516[i], ti_18517.base);
        }
      }
    
break;
case 28:       if (src_18516 !== null) {
        result_18829 = src_18516.slice(0);
      }
    
break;
default: 
result_18829 = src_18516;
break;
}
return result_18829;
}
function eqStrings(a_16003, b_16004) {

    if (a_16003 == b_16004) return true;
    if ((!a_16003) || (!b_16004)) return false;
    var alen = a_16003.length;
    if (alen != b_16004.length) return false;
    for (var i = 0; i < alen; ++i)
      if (a_16003[i] != b_16004[i]) return false;
    return true;
  }
function arrayConstr(len_19003, value_19004, typ_19005) {

      var result = new Array(len_19003);
      for (var i = 0; i < len_19003; ++i) result[i] = nimCopy(null, value_19004, typ_19005);
      return result;
    }
function cstrToNimstr(c_13603) {

  var ln = c_13603.length;
  var result = new Array(ln);
  var r = 0;
  for (var i = 0; i < ln; ++i) {
    var ch = c_13603.charCodeAt(i);

    if (ch < 128) {
      result[r] = ch;
    }
    else if((ch > 127) && (ch < 2048)) {
      result[r] = (ch >> 6) | 192;
      ++r;
      result[r] = (ch & 63) | 128;
    }
    else {
      result[r] = (ch >> 12) | 224;
      ++r;
      result[r] = ((ch >> 6) & 63) | 128;
      ++r;
      result[r] = (ch & 63) | 128;
    }
    ++r;
  }
  result[r] = 0; // terminating zero
  return result;
  }
function toJSStr(s_13803) {

    var len = s_13803.length-1;
    var asciiPart = new Array(len);
    var fcc = String.fromCharCode;
    var nonAsciiPart = null;
    var nonAsciiOffset = 0;
    for (var i = 0; i < len; ++i) {
      if (nonAsciiPart !== null) {
        var offset = (i - nonAsciiOffset) * 2;
        var code = s_13803[i].toString(16);
        if (code.length == 1) {
          code = "0"+code;
        }
        nonAsciiPart[offset] = "%";
        nonAsciiPart[offset + 1] = code;
      }
      else if (s_13803[i] < 128)
        asciiPart[i] = fcc(s_13803[i]);
      else {
        asciiPart.length = i;
        nonAsciiOffset = i;
        nonAsciiPart = new Array((len - i) * 2);
        --i;
      }
    }
    asciiPart = asciiPart.join("");
    return (nonAsciiPart === null) ?
        asciiPart : asciiPart + decodeURIComponent(nonAsciiPart.join(""));
  }
function raiseException(e_12806, ename_12807) {

e_12806.name = ename_12807;
if ((excHandler == 0)) {
unhandledException(e_12806);
}

e_12806.trace = nimCopy(null, rawwritestacktrace_12628(), NTI138);
throw e_12806;}
function addInt(a_16256, b_16257) {

      var result = a_16256 + b_16257;
      if (result > 2147483647 || result < -2147483648) raiseOverflow();
      return result;
    }
function subInt(a_16403, b_16404) {

      var result = a_16403 - b_16404;
      if (result > 2147483647 || result < -2147483648) raiseOverflow();
      return result;
    }
function chckIndx(i_19009, a_19010, b_19011) {

var Tmp1;
var result_19012 = 0;
BeforeRet: do {
if (!(a_19010 <= i_19009)) Tmp1 = false; else {Tmp1 = (i_19009 <= b_19011); }if (Tmp1) {
result_19012 = i_19009;
break BeforeRet;
}
else {
raiseIndexError();
}

} while (false); 
return result_19012;
}
function mulInt(a_16603, b_16604) {

      var result = a_16603 * b_16604;
      if (result > 2147483647 || result < -2147483648) raiseOverflow();
      return result;
    }
var nimvm_5554 = false;
var nim_program_result = 0;
var globalraisehook_10414 = [null];
var localraisehook_10419 = [null];
var outofmemhook_10422 = [null];
function isfatpointer_18498(ti_18500) {

var result_18501 = false;
BeforeRet: do {
result_18501 = !((SetConstr(17, 16, 4, 18, 27, 19, 23, 22, 21)[ti_18500.base.kind] != undefined));
break BeforeRet;
} while (false); 
return result_18501;
}
function nimCopyAux(dest_18520, src_18521, n_18523) {

switch (n_18523.kind) {
case 0: 
break;
case 1:       dest_18520[n_18523.offset] = nimCopy(dest_18520[n_18523.offset], src_18521[n_18523.offset], n_18523.typ);
    
break;
case 2: L1: do {
var i_18815 = 0;
var HEX3Atmp_18817 = 0;
HEX3Atmp_18817 = (n_18523.len - 1);
var res_18820 = 0;
L2: do {
L3: while (true) {
if (!(res_18820 <= HEX3Atmp_18817)) break L3;
i_18815 = res_18820;
nimCopyAux(dest_18520, src_18521, n_18523.sons[i_18815]);
res_18820 += 1;
}
} while(false);
} while(false);

break;
case 3:       dest_18520[n_18523.offset] = nimCopy(dest_18520[n_18523.offset], src_18521[n_18523.offset], n_18523.typ);
      for (var i = 0; i < n_18523.sons.length; ++i) {
        nimCopyAux(dest_18520, src_18521, n_18523.sons[i][1]);
      }
    
break;
}
}
function add_10438(x_10441, x_10441_Idx, y_10442) {

        var len = x_10441[0].length-1;
        for (var i = 0; i < y_10442.length; ++i) {
          x_10441[0][len] = y_10442.charCodeAt(i);
          ++len;
        }
        x_10441[0][len] = 0
      }
function auxwritestacktrace_12404(f_12406) {

var Tmp3;
var result_12407 = [null];
var it_12415 = f_12406;
var i_12416 = 0;
var total_12417 = 0;
var tempframes_12421 = arrayConstr(64, {Field0: null, Field1: 0}, NTI12409);
L1: do {
L2: while (true) {
if (!!((it_12415 == null))) Tmp3 = false; else {Tmp3 = (i_12416 <= 63); }if (!Tmp3) break L2;
tempframes_12421[i_12416].Field0 = it_12415.procname;
tempframes_12421[i_12416].Field1 = it_12415.line;
i_12416 += 1;
total_12417 += 1;
it_12415 = it_12415.prev;
}
} while(false);
L4: do {
L5: while (true) {
if (!!((it_12415 == null))) break L5;
total_12417 += 1;
it_12415 = it_12415.prev;
}
} while(false);
result_12407[0] = nimCopy(null, makeNimstrLit(""), NTI138);
if (!((total_12417 == i_12416))) {
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit("(")); } else { result_12407[0] = makeNimstrLit("(");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(cstrToNimstr(((total_12417 - i_12416))+"")); } else { result_12407[0] = cstrToNimstr(((total_12417 - i_12416))+"");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit(" calls omitted) ...\x0A")); } else { result_12407[0] = makeNimstrLit(" calls omitted) ...\x0A");};
}

L6: do {
var j_12615 = 0;
var HEX3Atmp_12621 = 0;
HEX3Atmp_12621 = (i_12416 - 1);
var res_12624 = HEX3Atmp_12621;
L7: do {
L8: while (true) {
if (!(0 <= res_12624)) break L8;
j_12615 = res_12624;
add_10438(result_12407, 0, tempframes_12421[j_12615].Field0);
if ((0 < tempframes_12421[j_12615].Field1)) {
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit(", line: ")); } else { result_12407[0] = makeNimstrLit(", line: ");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(cstrToNimstr((tempframes_12421[j_12615].Field1)+"")); } else { result_12407[0] = cstrToNimstr((tempframes_12421[j_12615].Field1)+"");};
}

if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit("\x0A")); } else { result_12407[0] = makeNimstrLit("\x0A");};
res_12624 -= 1;
}
} while(false);
} while(false);
return result_12407[0];
}
function rawwritestacktrace_12628() {

var result_12630 = null;
if (!((framePtr == null))) {
result_12630 = nimCopy(null, (makeNimstrLit("Traceback (most recent call last)\x0A").slice(0,-1)).concat(auxwritestacktrace_12404(framePtr)), NTI138);
}
else {
result_12630 = nimCopy(null, makeNimstrLit("No stack traceback available\x0A"), NTI138);
}

return result_12630;
}
function unhandledException(e_12654) {

var Tmp1;
var buf_12655 = /**/[makeNimstrLit("")];
if (!!(eqStrings(e_12654.message, null))) Tmp1 = false; else {Tmp1 = !((e_12654.message[0] == 0)); }if (Tmp1) {
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("Error: unhandled exception: ")); } else { buf_12655[0] = makeNimstrLit("Error: unhandled exception: ");};
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(e_12654.message); } else { buf_12655[0] = e_12654.message;};
}
else {
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("Error: unhandled exception")); } else { buf_12655[0] = makeNimstrLit("Error: unhandled exception");};
}

if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit(" [")); } else { buf_12655[0] = makeNimstrLit(" [");};
add_10438(buf_12655, 0, e_12654.name);
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("]\x0A")); } else { buf_12655[0] = makeNimstrLit("]\x0A");};
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(rawwritestacktrace_12628()); } else { buf_12655[0] = rawwritestacktrace_12628();};
var cbuf_12801 = toJSStr(buf_12655[0]);
framePtr = null;
  if (typeof(Error) !== "undefined") {
    throw new Error(cbuf_12801);
  }
  else {
    throw cbuf_12801;
  }
  }
function raiseOverflow() {

var e_13236 = null;
e_13236 = {m_type: NTI3440, parent: null, name: null, message: null, trace: null};
e_13236.message = nimCopy(null, makeNimstrLit("over- or underflow"), NTI138);
raiseException(e_13236, "OverflowError");
}
function raiseDivByZero() {

var e_13252 = null;
e_13252 = {m_type: NTI3438, parent: null, name: null, message: null, trace: null};
e_13252.message = nimCopy(null, makeNimstrLit("division by zero"), NTI138);
raiseException(e_13252, "DivByZeroError");
}
var state_25605 = /**/[{a0: 1773455756, a1: 4275166512}];
function gettime_44643() {

var result_45213 = null;
var F={procname:"times.getTime",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\pure\\times.nim",line:0};
framePtr = F;
BeforeRet: do {
F.line = 652;
result_45213 = new Date();
break BeforeRet;
} while (false); 
framePtr = F.prev;
return result_45213;
}
var startmilsecs_45264 = /**/[gettime_44643()];
function raiseIndexError() {

var e_13284 = null;
e_13284 = {m_type: NTI3452, parent: null, name: null, message: null, trace: null};
e_13284.message = nimCopy(null, makeNimstrLit("index out of bounds"), NTI138);
raiseException(e_13284, "IndexError");
}
function sysfatal_54228(message_54234) {

var F={procname:"sysFatal.sysFatal",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
F.line = 2543;
var e_54236 = null;
e_54236 = {m_type: NTI3456, parent: null, name: null, message: null, trace: null};
F.line = 2545;
e_54236.message = nimCopy(null, message_54234, NTI138);
F.line = 2546;
raiseException(e_54236, "RangeError");
framePtr = F.prev;
}
function HEX5BHEX5DHEX3D_54106(a_54113, x_54116, b_54119) {

var F={procname:"[]=.[]=",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
F.line = 3240;
var L_54201 = addInt(subInt(x_54116.b, x_54116.a), 1);
if ((L_54201 == (b_54119 != null ? b_54119.length : 0))) {
L1: do {
F.line = 3242;
var i_54226 = 0;
F.line = 1905;
var HEX3Atmp_54246 = 0;
F.line = 3242;
HEX3Atmp_54246 = subInt(L_54201, 1);
F.line = 1887;
var res_54249 = 0;
L2: do {
F.line = 1888;
L3: while (true) {
if (!(res_54249 <= HEX3Atmp_54246)) break L3;
F.line = 1889;
i_54226 = res_54249;
F.line = 3242;
a_54113[chckIndx(addInt(i_54226, x_54116.a), 0, a_54113.length)-0] = b_54119[chckIndx(i_54226, 0, b_54119.length)-0];
res_54249 = addInt(res_54249, 1);
}
} while(false);
} while(false);
}
else {
sysfatal_54228(makeNimstrLit("different lengths for slice assignment"));
}

framePtr = F.prev;
}
function HEX2EHEX2E_39449(a_39453, b_39455) {

var result_39457 = {a: 0, b: 0};
var F={procname:".....",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
F.line = 274;
result_39457.a = a_39453;
F.line = 275;
result_39457.b = b_39455;
framePtr = F.prev;
return result_39457;
}
function matrix2d_54012(arr_54043) {

var result_54075 = {data: null};
var F={procname:"matrix2D.matrix2D",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
result_54075.data = new Float64Array(9);
L1: do {
F.line = 63;
var i_54093 = 0;
F.line = 1887;
var res_54258 = 0;
L2: do {
F.line = 1888;
L3: while (true) {
if (!(res_54258 <= 2)) break L3;
F.line = 1889;
i_54093 = res_54258;
HEX5BHEX5DHEX3D_54106(result_54075.data, HEX2EHEX2E_39449(mulInt(i_54093, 3), subInt(addInt(mulInt(i_54093, 3), 3), 1)), arr_54043[chckIndx(i_54093, 0, arr_54043.length)-0]);
res_54258 = addInt(res_54258, 1);
}
} while(false);
} while(false);
framePtr = F.prev;
return result_54075;
}
var A_54262 = /**/[matrix2d_54012([[0.0, 5.0000000000000000e+000, 6.0000000000000000e+000], [4.0000000000000000e+000, 5.0000000000000000e+000, 7.0000000000000000e+000], [9.0000000000000000e+000, 2.0000000000000000e+000, 3.0000000000000000e+000]])];
function colvector_54274(arr_54295) {

var result_54330 = {data: null, iscol: false};
var F={procname:"colVector.colVector",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
result_54330.data = new Float64Array(3);
F.line = 30;
nimCopy(result_54330.data, arr_54295, NTI54282);
F.line = 31;
result_54330.iscol = true;
framePtr = F.prev;
return result_54330;
}
var b_54339 = /**/[colvector_54274([1.1000000000000000e+001, 1.6000000000000000e+001, 1.5000000000000000e+001])];
function nsuformatBiggestFloat(f_41410, format_41411, precision_41413, decimalsep_41414) {

var result_41415 = null;
var res_41601 = null;
switch (format_41411) {
case 0: res_41601 = f_41410.toString();
break;
case 1: res_41601 = f_41410.toFixed(precision_41413);
break;
case 2: res_41601 = f_41410.toExponential(precision_41413);
break;
}
result_41415 = nimCopy(null, cstrToNimstr(res_41601), NTI138);
L1: do {
var i_41611 = 0;
var HEX3Atmp_41625 = 0;
HEX3Atmp_41625 = (result_41415 != null ? result_41415.length-1 : 0);
var i_41628 = 0;
L2: do {
L3: while (true) {
if (!(i_41628 < HEX3Atmp_41625)) break L3;
i_41611 = i_41628;
if ((SetConstr(46, 44)[result_41415[i_41611]] != undefined)) {
result_41415[i_41611] = decimalsep_41414;
}

i_41628 += 1;
}
} while(false);
} while(false);
return result_41415;
}
function nsuformatFloat(f_41632, format_41633, precision_41635, decimalsep_41636) {

var result_41637 = null;
result_41637 = nimCopy(null, nsuformatBiggestFloat(f_41632, format_41633, precision_41635, decimalsep_41636), NTI138);
return result_41637;
}
function HEX24_55873(v_55910) {

var Tmp4;
var result_55911 = null;
var F={procname:"$.$",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\prettyprint.nim",line:0};
framePtr = F;
F.line = 33;
result_55911 = nimCopy(null, makeNimstrLit("["), NTI138);
if ((v_55910.data === null)) {
if (result_55911 != null) { result_55911 = (result_55911.slice(0, -1)).concat(makeNimstrLit("nil]\x0A")); } else { result_55911 = makeNimstrLit("nil]\x0A");};
}
else {
L1: do {
F.line = 36;
var i_55952 = 0;
F.line = 36;
var e_55953 = 0.0;
F.line = 2057;
var HEX3Atmp_55958 = new Float64Array(3);
F.line = 36;
HEX3Atmp_55958 = v_55910.data;
F.line = 2059;
var i_55961 = 0;
if ((i_55961 <= 2)) {
L2: do {
F.line = 2061;
L3: while (true) {
if (!true) break L3;
F.line = 2059;
i_55952 = i_55961;
F.line = 2062;
e_55953 = HEX3Atmp_55958[chckIndx(i_55961, 0, HEX3Atmp_55958.length)-0];
F.line = 37;
if ((0.0 <= e_55953)) {
Tmp4 = [43].concat(nsuformatFloat(e_55953, 1, 2, 46));
}
else {
Tmp4 = nsuformatFloat(e_55953, 1, 2, 46);
}

var fstring_55955 = nimCopy(null, Tmp4, NTI138);
if ((i_55952 == 2)) {
if (result_55911 != null) { result_55911 = (result_55911.slice(0, -1)).concat((fstring_55955.slice(0,-1)).concat(makeNimstrLit("]\x0A"))); } else { result_55911 = (fstring_55955.slice(0,-1)).concat(makeNimstrLit("]\x0A"));};
}
else {
if (v_55910.iscol) {
if (result_55911 != null) { result_55911 = (result_55911.slice(0, -1)).concat((fstring_55955.slice(0,-1)).concat(makeNimstrLit("|\x0A|"))); } else { result_55911 = (fstring_55955.slice(0,-1)).concat(makeNimstrLit("|\x0A|"));};
}
else {
if (result_55911 != null) { result_55911 = (result_55911.slice(0, -1)).concat((fstring_55955.slice(0,-1)).concat(makeNimstrLit(", "))); } else { result_55911 = (fstring_55955.slice(0,-1)).concat(makeNimstrLit(", "));};
}

}

if ((2 <= i_55961)) {
F.line = 2063;
break L2;
}

i_55961 = addInt(i_55961, 1);
}
} while(false);
}

} while(false);
}

framePtr = F.prev;
return result_55911;
}
function HEX5BHEX5D_54652(m_54688, i_54690, j_54692) {

var result_54693 = 0.0;
var F={procname:"[].[]",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
F.line = 79;
result_54693 = m_54688.data[chckIndx(addInt(mulInt(i_54690, 3), j_54692), 0, m_54688.data.length)-0];
framePtr = F.prev;
return result_54693;
}
function findrowwithmaxincol_54612(A_54647, col_54649) {

var result_54650 = 0;
var F={procname:"findRowWithMaxInCol.findRowWithMaxInCol",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\solver.nim",line:0};
framePtr = F;
F.line = 102;
var lastmax_54694 = HEX5BHEX5D_54652(A_54647, 0, col_54649);
L1: do {
F.line = 103;
var i_54704 = 0;
F.line = 3632;
var i_54794 = 0;
L2: do {
F.line = 3633;
L3: while (true) {
if (!(i_54794 < 3)) break L3;
F.line = 3632;
i_54704 = i_54794;
if ((lastmax_54694 < HEX5BHEX5D_54652(A_54647, i_54704, col_54649))) {
F.line = 106;
lastmax_54694 = HEX5BHEX5D_54652(A_54647, i_54704, col_54649);
F.line = 107;
result_54650 = i_54704;
}

i_54794 = addInt(i_54794, 1);
}
} while(false);
} while(false);
framePtr = F.prev;
return result_54650;
}
function HEX5BHEX5DHEX3D_54937(m_54974, i_54976, j_54978, val_54980) {

var F={procname:"[]=.[]=",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
F.line = 81;
m_54974.data[chckIndx(addInt(mulInt(i_54976, 3), j_54978), 0, m_54974.data.length)-0] = val_54980;
framePtr = F.prev;
}
function swaprow_54798(A_54834, frm_54836, to_54838) {

var F={procname:"swapRow.swapRow",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\solver.nim",line:0};
framePtr = F;
L1: do {
F.line = 111;
var i_54848 = 0;
F.line = 3632;
var i_55029 = 0;
L2: do {
F.line = 3633;
L3: while (true) {
if (!(i_55029 < 3)) break L3;
F.line = 3632;
i_54848 = i_55029;
F.line = 112;
var f_54892 = HEX5BHEX5D_54652(A_54834, frm_54836, i_54848);
HEX5BHEX5DHEX3D_54937(A_54834, frm_54836, i_54848, HEX5BHEX5D_54652(A_54834, to_54838, i_54848));
HEX5BHEX5DHEX3D_54937(A_54834, to_54838, i_54848, f_54892);
i_55029 = addInt(i_55029, 1);
}
} while(false);
} while(false);
framePtr = F.prev;
}
function HEX5BHEX5D_55033(v_55070, i_55072) {

var result_55073 = 0.0;
var F={procname:"[].[]",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
if (!((v_55070.data == null))) {
F.line = 45;
result_55073 = v_55070.data[chckIndx(i_55072, 0, v_55070.data.length)-0];
}

framePtr = F.prev;
return result_55073;
}
function HEX5BHEX5DHEX3D_55130(v_55167, i_55169, val_55171) {

var F={procname:"[]=.[]=",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\types.nim",line:0};
framePtr = F;
F.line = 47;
v_55167.data[chckIndx(i_55169, 0, v_55167.data.length)-0] = val_55171;
framePtr = F.prev;
}
function divrowbyfloat_55260(A_55296, row_55298, val_55300) {

var F={procname:"divRowByFloat.divRowByFloat",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\operations.nim",line:0};
framePtr = F;
L1: do {
F.line = 136;
var j_55310 = 0;
F.line = 3632;
var i_55402 = 0;
L2: do {
F.line = 3633;
L3: while (true) {
if (!(i_55402 < 3)) break L3;
F.line = 3632;
j_55310 = i_55402;
HEX5BHEX5DHEX3D_54937(A_55296, row_55298, j_55310, (HEX5BHEX5D_54652(A_55296, row_55298, j_55310) / val_55300));
i_55402 = addInt(i_55402, 1);
}
} while(false);
} while(false);
framePtr = F.prev;
}
function subtractrows_55545(A_55581, fm_55583, wht_55585, tims_55587) {

var F={procname:"subtractRows.subtractRows",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\solver.nim",line:0};
framePtr = F;
L1: do {
F.line = 118;
var j_55597 = 0;
F.line = 3632;
var i_55732 = 0;
L2: do {
F.line = 3633;
L3: while (true) {
if (!(i_55732 < 3)) break L3;
F.line = 3632;
j_55597 = i_55732;
HEX5BHEX5DHEX3D_54937(A_55581, fm_55583, j_55597, (HEX5BHEX5D_54652(A_55581, fm_55583, j_55597) - (HEX5BHEX5D_54652(A_55581, wht_55585, j_55597) * tims_55587)));
i_55732 = addInt(i_55732, 1);
}
} while(false);
} while(false);
framePtr = F.prev;
}
function solve_54343(A_54378, b_54413) {

var result_54447 = {data: null, iscol: false};
var F={procname:"solve.solve",prev:framePtr,filename:"c:\\users\\silvio\\documents\\dev\\nim\\nalg\\private\\solver.nim",line:0};
framePtr = F;
F.line = 123;
var tempa_54448 = /**/[nimCopy(null, A_54378, NTI54348)];
L1: do {
F.line = 128;
var i_54610 = 0;
F.line = 3632;
var i_55870 = 0;
L2: do {
F.line = 3633;
L3: while (true) {
if (!(i_55870 < 3)) break L3;
F.line = 3632;
i_54610 = i_55870;
if (!((i_54610 == 2))) {
F.line = 130;
var imx_54796 = findrowwithmaxincol_54612(tempa_54448[0], i_54610);
swaprow_54798(tempa_54448[0], imx_54796, i_54610);
F.line = 133;
var tmp_55086 = HEX5BHEX5D_55033(result_54447, imx_54796);
HEX5BHEX5DHEX3D_55130(result_54447, imx_54796, HEX5BHEX5D_55033(result_54447, i_54610));
HEX5BHEX5DHEX3D_55130(result_54447, i_54610, tmp_55086);
}

F.line = 137;
var piv_55258 = HEX5BHEX5D_54652(tempa_54448[0], i_54610, i_54610);
divrowbyfloat_55260(tempa_54448[0], i_54610, piv_55258);
HEX5BHEX5DHEX3D_55130(result_54447, i_54610, (HEX5BHEX5D_55033(result_54447, i_54610) / piv_55258));
L4: do {
F.line = 141;
var j_55499 = 0;
F.line = 3632;
var i_55866 = 0;
L5: do {
F.line = 3633;
L6: while (true) {
if (!(i_55866 < 3)) break L6;
F.line = 3632;
j_55499 = i_55866;
if (!((j_55499 == i_54610))) {
F.line = 144;
var tims_55543 = HEX5BHEX5D_54652(tempa_54448[0], j_55499, i_54610);
subtractrows_55545(tempa_54448[0], j_55499, i_54610, tims_55543);
HEX5BHEX5DHEX3D_55130(result_54447, j_55499, (HEX5BHEX5D_55033(result_54447, j_55499) - (HEX5BHEX5D_55033(result_54447, i_54610) * tims_55543)));
}

i_55866 = addInt(i_55866, 1);
}
} while(false);
} while(false);
i_55870 = addInt(i_55870, 1);
}
} while(false);
} while(false);
F.line = 148;
result_54447.iscol = true;
framePtr = F.prev;
return result_54447;
}
function sysfatal_20821(message_20827) {

var F={procname:"sysFatal.sysFatal",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
F.line = 2543;
var e_20829 = null;
e_20829 = {m_type: NTI3444, parent: null, name: null, message: null, trace: null};
F.line = 2545;
e_20829.message = nimCopy(null, message_20827, NTI138);
F.line = 2546;
raiseException(e_20829, "AssertionError");
framePtr = F.prev;
}
function raiseassert_20816(msg_20818) {

var F={procname:"system.raiseAssert",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
sysfatal_20821(msg_20818);
framePtr = F.prev;
}
function failedassertimpl_20839(msg_20841) {

var F={procname:"system.failedAssertImpl",prev:framePtr,filename:"c:\\dev\\nim-devel\\lib\\system.nim",line:0};
framePtr = F;
raiseassert_20816(msg_20841);
framePtr = F.prev;
}
if (!(eqStrings(HEX24_55873(solve_54343(A_54262[0], b_54339[0])), makeNimstrLit("[+1.15|\x0A|+1.73|\x0A|+0.39]\x0A")))) {
failedassertimpl_20839(makeNimstrLit("$ solve(A, b) == \"[+1.15|\\x0A|+1.73|\\x0A|+0.39]\\x0A\" "));
}

function log_56001(str_56004) {

var F={procname:"webtest.log",prev:framePtr,filename:"webtest.nim",line:0};
framePtr = F;
F.line = 9;
console.log(str_56004);framePtr = F.prev;
}
log_56001([A_54262[0]]);
log_56001([b_54339[0]]);
log_56001([solve_54343(A_54262[0], b_54339[0])]);