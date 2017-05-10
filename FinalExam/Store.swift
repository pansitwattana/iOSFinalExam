//
//  Store.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/9/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//
import Foundation
import RealmSwift
import SwiftyJSON

class Store: Object {
    dynamic var name = ""
    dynamic var type = ""
    dynamic var detail = ""
    dynamic var tel = ""
    dynamic var address = ""
    dynamic var open = ""
    dynamic var close = ""
    dynamic var latitude = ""
    dynamic var longitude = ""
}
//"id": "1",
//"name": "Cafe Kantary Chiang Mai",
//"type": "ร้านกาแฟ/ชา , อาหารไทย , เบเกอรี่/เค้ก",
//"detail": "ร้าน Cafe Kantar ถือเป็นส่วนหนึ่งของโรงแรมคันทารี่ ฮิลล์ เชียงใหม่ ร้านนี้จะเป็นร้านขนมและร้านกาแฟประจำโรงแรมเลยก็ว่าได้ครับ ซึ่งร้านนี้จะไม่ได้ตั้งอยู่ในโรงแรมนะครับ จะปลีกตัวออกมาตั้งอยู่บริเวณใกล้ริมถนนนิมมานเหมินทร์เลย หาได้ง่ายมากในโครงการ Kantary Terrace",
//"tel": "053-222-111, 053-400-877",
//"address": "44,44/1-2 ถนนนิมมานเหมินท์ ซอย 12 ต.สุเทพ อ.เมือง จ.เชียงใหม่",
//"open": "09.00",
//"close": "20.00",
//"latitude": "18.796544",
//"longtitude": "98.964961"
