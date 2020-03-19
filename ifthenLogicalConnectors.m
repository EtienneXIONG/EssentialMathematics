
ifthen = @(p,q)~p|q
iff = @(p,q) ifthen(p,q) & ifthen(q,p)
proposition = @(p,q)  iff(ifthen(p,q)&~q,p|q)

proposition(true,true)
proposition(true,false)
proposition(false,true)
proposition(false,false)