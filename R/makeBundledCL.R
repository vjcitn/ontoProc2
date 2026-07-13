# not exported, script that creates saved data vectors
makeBundledMaps = function() {
 cl = semsql_connect(ontology="cl")
 thmap = dplyr::tbl(cl@con, "rdfs_label_statement") |> dplyr::filter(subject %like% "%CL:%") |> 
     select(subject, value) |> as.data.frame() 
 cn2tag = thmap$subject
 names(cn2tag) = thmap$value
# save(cn2tag, file="cn2tag.rda", compress="xz")
 tag2cn = thmap$value
 names(tag2cn) = thmap$subject
# save(tag2cn, file="tag2cn.rda", compress="xz")
 nn = semsql_connect(ontology="ncit")
 tbl(nn@con, "rdfs_label_statement") |> as.data.frame() -> newnc
 ncit_map = newnc$value
 names(ncit_map) = newnc$subject
 list(tag2cn=tag2cn, cn2tag=cn2tag, ncit_map=ncit_map)
}
