import Fluent
import Vapor

final class Event: Model, Content {
    
    static let schema = "event"
    
    @ID
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "date")
    var date: String
    
    @Field(key: "location")
    var location: String
    
    init() {
        
    }

    init(id: UUID? = nil, title: String, date: String, location: String) {
        self.id = id
        self.title = title
        self.date = date
        self.location = location
       
    }
}
