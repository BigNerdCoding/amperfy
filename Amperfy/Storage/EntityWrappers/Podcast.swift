import Foundation
import CoreData
import UIKit

enum PodcastRemoteStatus: Int {
    case available = 0
    case deleted = 1
}

public class Podcast: AbstractLibraryEntity, PlayableContainable {
    
    let managedObject: PodcastMO
    
    init(managedObject: PodcastMO) {
        self.managedObject = managedObject
        super.init(managedObject: managedObject)
    }
    
    var identifier: String {
        return title
    }
    var title: String {
        get { return managedObject.title ?? "Unknown Podcast" }
        set { if managedObject.title != newValue { managedObject.title = newValue } }
    }
    var depiction: String {
        get { return managedObject.depiction ?? "" }
        set { if managedObject.depiction != newValue { managedObject.depiction = newValue } }
    }
    var remoteStatus: PodcastRemoteStatus {
        get { return PodcastRemoteStatus(rawValue: Int(managedObject.status)) ?? .available }
        set { if managedObject.status != newValue.rawValue { managedObject.status = Int16(newValue.rawValue) } }
    }
    var episodes: [PodcastEpisode] {
        guard let episodesSet = managedObject.episodes, let episodesMO = episodesSet.array as? [PodcastEpisodeMO] else { return [PodcastEpisode]() }
        return episodesMO.compactMap{ PodcastEpisode(managedObject: $0) }.filter{ $0.userStatus != .deleted }.sortByPublishDate()
    }
    var playables: [AbstractPlayable] { return episodes }
    
    override var image: UIImage {
        if super.image != Artwork.defaultImage {
            return super.image
        }
        return Artwork.defaultImage
    }

}

extension Podcast: Hashable, Equatable {
    public static func == (lhs: Podcast, rhs: Podcast) -> Bool {
        return lhs.managedObject == rhs.managedObject && lhs.managedObject == rhs.managedObject
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(managedObject)
    }
}
