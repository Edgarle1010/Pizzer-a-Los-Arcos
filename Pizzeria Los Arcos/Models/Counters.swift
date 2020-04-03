//
//  Counters.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 30/03/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

// counters/${ID}
struct Counter {
    let numShards: Int

    init(numShards: Int) {
        self.numShards = numShards
    }
}

// counters/${ID}/shards/${NUM}
struct Shard {
    let count: Int

    init(count: Int) {
        self.count = count
    }
}
