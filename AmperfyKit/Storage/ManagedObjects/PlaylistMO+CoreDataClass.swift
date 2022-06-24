import Foundation
import CoreData

@objc(PlaylistMO)
public final class PlaylistMO: NSManagedObject {

    static var excludeSystemPlaylistsFetchPredicate: NSPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == nil", #keyPath(PlaylistMO.playersContextPlaylist)),
            NSPredicate(format: "%K == nil", #keyPath(PlaylistMO.playersShuffledContextPlaylist)),
            NSPredicate(format: "%K == nil", #keyPath(PlaylistMO.playersUserQueuePlaylist)),
            NSPredicate(format: "%K == nil", #keyPath(PlaylistMO.playersPodcastPlaylist))
        ])
    }
    
    static var lastPlayedDateFetchRequest: NSFetchRequest<PlaylistMO> {
        let fetchRequest: NSFetchRequest<PlaylistMO> = PlaylistMO.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(PlaylistMO.lastPlayedDate), ascending: false),
            NSSortDescriptor(key: #keyPath(PlaylistMO.name), ascending: true, selector: #selector(NSString.localizedStandardCompare)),
            NSSortDescriptor(key: #keyPath(PlaylistMO.id), ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
        return fetchRequest
    }

    static var lastChangedDateFetchRequest: NSFetchRequest<PlaylistMO> {
        let fetchRequest: NSFetchRequest<PlaylistMO> = PlaylistMO.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(PlaylistMO.changeDate), ascending: false),
            NSSortDescriptor(key: #keyPath(PlaylistMO.name), ascending: true, selector: #selector(NSString.localizedStandardCompare)),
            NSSortDescriptor(key: #keyPath(PlaylistMO.id), ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
        return fetchRequest
    }

}

extension PlaylistMO: CoreDataIdentifyable {
    
    static var identifierKey: KeyPath<PlaylistMO, String?> {
        return \PlaylistMO.name
    }
    
    func passOwnership(to targetPlaylist: PlaylistMO) {
    }
    
}
