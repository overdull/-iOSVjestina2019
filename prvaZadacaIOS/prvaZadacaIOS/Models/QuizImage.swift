//
//  QuizImage.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 09/04/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import Foundation
//
//  FlagType.swift
//  Project22
//
//  Created by Josip Maric on 27/03/2019.
//  Copyright © 2019 Josip Maric. All rights reserved.
//


// primjer kako koristimo Enum za implementirat dio modela
// ovdje implementiramo tip zastave
enum QuizImage {
    
    // dva su tipa zastave, svaki ima pridruzenu vrijednost tipa String // pogledati u InitialViewController kako inicijaliziramo FlagType
    case shiny(String)
    case flat(String)
    
    // enum ima computed property urlString koji vraca URL s kojeg se dohvaca zastav
    // sadrzaj urlString-a ovisi o samom enumu, pri cemo ovdje koristimo druga dva computed propertyja za stvaranje URLa
    var urlString: String {
        return "https://www.countryflags.io/\(self.code)/\(self.text)/64.png"
    }
    
    // code computed property vraca kod zastave, tj pridruzenu vrijednost enuma kojom smo u InitialViewControlleru inicijalizirali enum, npr. hr, us, be, is...
    //
    var code: String {
        
        // ovo je ucestali pattern, gdje radim switch case po samom enum objektu
        // ovdje odmah vidimo pattern matching gdje u case dijelu odmah izdvajamo pridruzenu vrijednost enuma
        // tu pridruzenu vrijednost enuma i vracamo kao vrijednost koda (sto ona i je)
        // buduci da su switch case-ovi exaustive, ako dodamo novi case u enum uvijek moramo dodati i 'hendlanje' tog case u sve switch case petlje koje 'switch-caseaju' taj enum
        switch self {
        case .flat(let value):
            return value
        case .shiny(let value):
            return value
        }
    }
    
    var text: String {
        switch self {
        case .shiny:
            return "shiny"
        case .flat:
            return "flat"
        }
    }
    
}
