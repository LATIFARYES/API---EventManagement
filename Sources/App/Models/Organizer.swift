
import Fluent
import Vapor

final class Organizer: Model, Content {
    
    static let schema = "organizer"
    
    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "ContactInfo")
    var ContactInfo: String
    
    init() {
        
    }

    init(id: UUID? = nil, name: String, ContactInfo: String) {
        self.id = id
        self.name = name
        self.ContactInfo = ContactInfo
    }
}
