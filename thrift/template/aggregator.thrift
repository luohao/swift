namespace cpp pull_star_thrift

service Aggregator {
    set<i64> regexSearch(1:string query),
    list<i64> search(1:string query),
    i32 init()
}
