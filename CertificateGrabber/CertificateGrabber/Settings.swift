//
//  Settings.swift
//  CertificateGrabber
//
//  Created by Alaa on 02/04/2024.
//

import Foundation


struct Settinga: Codable {
    let success: Bool
    let data: DataClass
    let errorResp: String?
    let code: Int

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case data
        case errorResp = "Error_Resp"
        case code = "Code"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let otpPageDashboard, rememberMeDashboard, recaptchaDashboard, otpPageEmployee: Bool
    let rememberMeEmployee, recaptchaEmployee: Bool
    let languages: [String]
    let propertyRightsTextKey: String
    let propertyRightsText: Bool
    let propertyRightsInAPP: [String]
    let dashboardLoginArabicLogo, dashboardLoginEnglishLogo, dashboardHomeArabicLogo, dashboardHomeEnglishLogo: String
    let sessionMinutes: Int
    let moreDevice, moreBrowser: Bool

    enum CodingKeys: String, CodingKey {
        case otpPageDashboard = "otpPage_Dashboard"
        case rememberMeDashboard = "rememberMe_Dashboard"
        case recaptchaDashboard = "Recaptcha_Dashboard"
        case otpPageEmployee = "otpPage_Employee"
        case rememberMeEmployee = "rememberMe_Employee"
        case recaptchaEmployee = "Recaptcha_Employee"
        case languages = "Languages"
        case propertyRightsTextKey = "PropertyRightsTextKey"
        case propertyRightsText = "PropertyRightsText"
        case propertyRightsInAPP = "PropertyRightsInAPP"
        case dashboardLoginArabicLogo = "DashboardLoginArabicLogo"
        case dashboardLoginEnglishLogo = "DashboardLoginEnglishLogo"
        case dashboardHomeArabicLogo = "DashboardHomeArabicLogo"
        case dashboardHomeEnglishLogo = "DashboardHomeEnglishLogo"
        case sessionMinutes = "SessionMinutes"
        case moreDevice = "MoreDevice"
        case moreBrowser = "MoreBrowser"
    }
}
