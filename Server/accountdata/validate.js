var objectIdList = {'ids': ['data']}

// Puzzle Sync Objects
var objectPuzzle = {'id': 'data', 'attributes': {'[string]': 'data'}};
var objectConflict = {'remotePuzzle': objectPuzzle, 'localId': 'data'};
var objectRename = {'id': 'data', 'name': 'string'};

// Session Sync Objects
var objectSolve = {'scramble': 'string', 'date': 'number', 'status': 'int',
                   'time': 'number', 'inspectionTime': 'number'};
var objectSession = {'puzzleId': 'data', 'solves': [objectSolve]};
var objectHashes = {'idPrefix': 'data', 'length': 'int', 'hashes': {'[data]': '[data]'}};

var formats = {
    'puzzles': {
        'add': {'puzzles': [objectPuzzle]},
        'replace': {'remoteId': 'data', 'puzzle': objectPuzzle},
        'renameThenAdd': {'remoteId': 'data', 'name': 'string', 'puzzle': objectPuzzle},
        'rename': {'renames': [objectRename]},
        'deleteThenRename': {'deleteId': 'data', 'rename': objectRename},
        'setValues': {'sets': [{'id': 'data', 'attribute': 'string', 'value': 'data'}]},
        'delete': objectIdList,
        'list': {},
        'myOrder': objectIdList
    },
    'sessions': {
        'delete': objectIdList,
        'add': {'sessions': [objectSession]},
        'getHashes': {'idPrefix': 'data', 'length': 'int'},
        'getDiff': {'idPrefix': 'data', 'ids': ['data']}
    },
    'account': {
        'setValues': {'attributes': [{'attribute': 'string', 'value': 'data'}]},
        'getAccount': {},
        'signin': {'username': 'string', 'hash': 'data'}
    }
};

function lookupAPICall(var name) {
    var list = name.split('.');
    if (list.length != 2) return null;
    if (!formats[list[0]]) {
        return null;
    }
    if (!formats[list[0]][list[1]]) {
        return null;
    }
    return formats[list[0]][list[1]];
}

function validateAPICallType(var name, var obj) {
    var expectedObj = lookupAPICall(name);
    if (!expectedObj) return false;
    
    // todo: validate each object and sub-object etc.
}
