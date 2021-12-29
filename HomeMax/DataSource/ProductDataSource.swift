//
//  ProductDataSource.swift
//  HomeMax
//
//  Created by Ikmal Azman on 25/12/2021.
//

import Foundation

struct ProductDataSource {
    let data = [
        Product(name: "Sofa", description:
"""
Readily converts into a bed.

Big, practical storage space under the seat.

10 year guarantee. Read about the terms in the guarantee brochure.

This cover’s ability to resist abrasion has been tested to handle 35,000 cycles. 15,000 cycles or more is suitable for furniture used every day at home. Over 30,000 cycles means a good ability to resist abrasion.

The cover has a lightfastness level of 5 (the ability to resist colour fading) on a scale of 1 to 8. According to industry standards, a lightfastness level of 4 or higher is suitable for home use.
""",
                image: "Sofa", price: 400),
        Product(name: "Bastone", description:
                    """
In this TV storage combination, there’s room for your TV and for displaying your favourite belongings behind glass doors.

It’s easy to keep the cables from your TV and other devices out of sight but close at hand, as there are several cable outlets at the back of the TV bench.

The cable outlet at the top lets cables run down smoothly into the TV bench.

The drawer has an integrated push-opener, so you don’t need handles or knobs and can open it with just a light push.

The shelves are adjustable so you can customise your storage as needed.

The space-saving wall cabinets make the most of the wall area above your TV.

Optimise and organise your Bastone storage with boxes and inserts that you like.
""",
                image: "Bastone", price: 550),
        Product(name: "Bookcase", description:
                    """
The simple design with clean lines makes it flexible and easy to use at home.

The smooth surfaces and the rounded edges give the shelving unit a well-thought-out and solid look.

The shelves align perfectly with the frame to create a strong and uniform expression.

The flexible and adaptable construction makes it possible for you to enjoy your bookcase for many years, even when your needs change or when you move.

Display your favourite items on the open shelves or add inserts to create a personalised solution with closed storage.
""",
                image: "Bookcase", price: 299),
        Product(name: "Dresser", description:
"""
Of course your home should be a safe place for the entire family. That’s why a safety fitting is included so that you can attach the chest of drawers to the wall.

Smooth running drawers with pull-out stop.

The drawer holds about 15 pairs of folded trousers or 30 T-shirts.

WARNING! TIPPING HAZARD – Unanchored furniture can tip over. This furniture shall be anchored to the wall with the enclosed safety fitting to prevent it from tipping over.

""",
                image: "Dresser", price: 310),
    ]
}
