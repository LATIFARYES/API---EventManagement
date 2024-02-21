
import Fluent
import Vapor

final class Renter: Model, Content {
    
    static let schema = "renter"
    
    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "ContactInfo")
    var ContactInfo: String
    
    @Field(key: "Rented")
    var Rented: Bool
    
    init() {
        
    }

    init(id: UUID? = nil, name: String, ContactInfo: String, Rented: Bool) {
        self.id = id
        self.name = name
        self.ContactInfo = ContactInfo
        self.Rented = Rented
    }
}
