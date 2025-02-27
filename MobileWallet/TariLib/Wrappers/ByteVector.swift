//  ByteVector.swift

/*
	Package MobileWallet
	Created by Jason van den Berg on 2019/11/14
	Using Swift 5.0
	Running on macOS 10.15

	Copyright 2019 The Tari Project

	Redistribution and use in source and binary forms, with or
	without modification, are permitted provided that the
	following conditions are met:

	1. Redistributions of source code must retain the above copyright notice,
	this list of conditions and the following disclaimer.

	2. Redistributions in binary form must reproduce the above
	copyright notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.

	3. Neither the name of the copyright holder nor the names of
	its contributors may be used to endorse or promote products
	derived from this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
	CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
	OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
	HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation

class ByteVector {
    private var ptr: OpaquePointer

    init(byteArray: [UInt8]) {
        self.ptr = byte_vector_create(byteArray, UInt32(byteArray.count))
    }

    init (pointer: OpaquePointer) {
        ptr = pointer
    }

    func length() -> UInt32 {
        return byte_vector_get_length(ptr)
    }

    func at(position: UInt32) -> UInt8 {
        return byte_vector_get_at(ptr, position)
    }

    func toString() -> String {
        var byteArray: [UInt8] = [UInt8]()

        for n in 0...length() {
            byteArray.append(at(position: n))
        }

        let data = Data(byteArray)

        var hexStr = data.map {String(format: "%02hhx", $0)}.joined()

        //TODO figure out why the last 2 zeros need to be dropped
        if hexStr.count > 2 {
            hexStr = String(hexStr.dropLast(2))
        }

        return hexStr
    }

    func pointer() -> OpaquePointer {
        return ptr
    }

    deinit {
        byte_vector_destroy(ptr)
    }
}
