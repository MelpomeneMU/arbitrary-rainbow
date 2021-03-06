/*
Dependencies:
    alert()
    wheader()
    wfooter()
    isstaff()
    boxtext()
    titlestr()
    A player named "GridOwner" <-- make one or this code will open a security risk and throw a lot of errors.

Documentation:

These are commands anyone can use anywhere on the grid, but some of them only work when the player is on the list of owners for the room.

Purpose: To give players a sense of ownership and security on the grid.

We provide a simple form of locking: +lock o will lock both your Out exit and its corresponding entrance, assuming it's set up correctly. When the door is locked, only people with keys can pass.

Please note that teleportation commands still work as normal - 'home', +meetme, +travel, +ic, etc, will all still bring players into locked buildings, and they can still leave with those commands as well.

In addition, staff can pass these locks, as they need to get to various places on the grid to fix exits as they find them.

 * +lock <exit> - lock an exit you control.

 * +unlock <exit> - unlock an exit you control.

Locks are controlled by keys. The owner(s) of a location can hand them out with:

 * +key/give [<#room or here>=]<player> - give someone a key

 * +key/take [<#room or here>=]<player> - take away their key

 * +keys [<#room or here>] - list everyone who has keys to that particular location

This code also allows you some control over views and description in your room. You will not be able to make or remove the "Owner" view, since that is code-based, but you can add and remove other views, and can completely change the description.

 * +view/set [<location>/]<title>=<view> - add, update, or remove a +view

 * +view/add [<location>/]<title>=<view> - add a +view

 * +view/remove [<location>/]<title> - remove a +view

 * +desc <#room or here>=<description> - edit the description

Finally, as the owner of a room, you have the ability to let other people make changes to your space.

 * +owners [<#room or here>] - list everyone who has the ability to modify this area. (You can see this same information on the +view here/Owners view.)

 * +owner/add [<#room or here>=]<player> - allow <player> to change the room you're in the same way you can. Be warned that they can remove you from the owners' list, so only add people you trust! If problems come up with this, please submit a +request to staff.

 * +owner/remove [<#room or here>=]<player> - remove a player from the list of owners. Note: you can remove yourself if you no longer want to manage the location.

Staff commands:

 * +ep <name of a local exit or #exit>=<#exit> - pair two exits together. Hereafter, all locks will work on the paired exits as if they were a single door. You can use a name for the local exit, but you'll need to know the dbref of the remote exit.

 * +ep <exit name> - will save that exit and send you through it. On the other side, you'll need to +ep <its twin> and it'll assign the two exits as paired.

 * +owners/clean - clean old owners off all the builds on the grid. Available as a trigger to be tied to the cg/freeze process.

Change log:

2020-07-10: Fixed these bugs:
    - Log ownership transfers
    - Display the logs in +owners to staff
    - Emit owner changes to the Monitor channel
    - Make the owners view not show "the previous owners view was..." when it's the default text.

2020-08-15: Added code to remove owner views from locations with no owners, and remove frozen owners from locations.

*/
@create Exit Parent <EP>=10
@set EP=INHERIT

@create Grid Functions <GF>=10
@set GF=INHERIT

@create Grid Commands <GC>=10
@set GC=INHERIT
@parent GC=GF

@force me=&d.ep me=num(EP)

@force me=&d.gf me=num(GF)

@force me=&d.gc me=num(GC)

@@ This step parents all the exits on the grid to your new exit parent.

@dolist search(TYPE=exit)=@parent ##=[v(d.ep)];

@@ SIDE NOTE:
@@ 
@@ At this point, you should probably go into your netmux.conf and add the line "exit_parent 123" where "123" is the number of EP without the #.
@@ 
@@ If you don't do that, future exits will not look the same as existing exits.
@@ 

@force me=&d.grid-owner GF=search(player=GridOwner)

@force me=&d.exit-parent GF=v(d.ep)

@force me=&VK [v(d.ep)]=[v(d.gf)]

@tel EP=[v(d.gf)]
@tel [v(d.gf)]=[v(d.gc)]

@desc [v(d.ep)]=if(hasflag(me, transparent), A path leading to..., A path leading to [name(loc(me))].)

@descformat [v(d.ep)]=strcat(alert(), %b, name(me) -, %b, ulocal(desc))

@ofail [v(d.ep)]=strcat(tries to go into, %b, trim(first(name(me), <)), %, but the door is locked.)

@fail [v(d.ep)]=strcat(alert(), %b, trim(first(name(me), <)) is locked.)

&d.default-lock [v(d.ep)]=[u(%vK/f.haskey, %#, %!)]

&.msg [v(d.gf)]=alert(Grid Msg) %0

&.remit [v(d.gf)]=alert() %0

&.error-msg [v(d.gf)]=alert(Grid Err) %0

&.emit_channel [v(d.gf)]=Monitor

@@ %0 - viewer
@@ %1 - room they're looking at
@@ %2 - key-holder
&layout.key-line [v(d.gf)]=strcat(space(3), xget(%1, _key-%2))

@@ %0 - viewer
@@ %1 - room they're looking at
&layout.keys [v(d.gf)]=strcat(wheader(name(%1), %0), %r, wdivider(Room keys), setq(O, ulocal(f.get-keys, %1)), %r%r, if(gt(words(%qO), 0), strcat(boxtext(strcat(The following, %b, if(gt(words(%qO), 1), people have, person has), %b, keys to this build:),,, %0, 3), %r%r, iter(%qO, ulocal(layout.key-line, %0, %1, itext(0)),, %r)), boxtext(No one has a key to this place at the moment. Please contact staff via %chreq/build%cn if you have questions or comments.,,, %0, 3)), %r%r, wfooter(, %0))

@@ %0 - viewer
@@ %1 - room they're looking at
@@ %2 - owner
&layout.owner-line [v(d.gf)]=strcat(setq(W, width(%0)), setq(N, name(%2)), setq(P, default(%2/position-%1, &position-%1 not set.)), space(3), %qN, %b, repeat(., sub(%qW, add(2, 6, strlen(%qN), strlen(%qP)))), %b, %qP)

@@ %0 - viewer
@@ %1 - room they're looking at
&layout.owners [v(d.gf)]=strcat(wheader(name(%1), %0), %r, wdivider(Room owners), setq(O, ulocal(f.get-owners, %1)), %r%r, if(gt(words(%qO), 0), strcat(boxtext(strcat(The following, %b, if(gt(words(%qO), 1), people, person), %b, may be reached for OOC questions/comments regarding this build:),,, %0, 3), %r%r, iter(%qO, ulocal(layout.owner-line, %0, %1, itext(0)),, %r)), boxtext(strcat(This place has no registered owners at the moment. Please contact staff via %chreq/build%cn if you have questions or comments., if(hasattr(%1, view-owner), strcat(%r%r, The old owner view:, %b, ulocal(%1/view-owner))), if(cand(hasattr(%1, view-owners), not(strmatch(xget(%1, view-owners), This location has owners. Use +owners to view them.))), strcat(%r%r, The old owners view:, %b, ulocal(%1/view-owners)))),,, %0, 3)), if(cand(isstaff(%0), hasattr(%1, _owner-log)), strcat(%r%r, space(3), Ownership history (staff only):, %r%r, wrap(trim(edit(xget(%1, _owner-log), .%b, .%r%r)), sub(width(%0), 6), left, space(3)))), %r%r, wfooter(, %0))

@@ %0 - person to test
@@ %1 - object to test whether they own
&f.isowner [v(d.gf)]=cor(isstaff(%0), cand(isapproved(%0), if(hastype(%1, EXIT), cor(hasattr(loc(%1), _owner-%0), hasattr(loc(xget(%1, _exit-pair)), _owner-%0)), hasattr(%1, _owner-%0))))

@@ %0 - person to test
@@ %1 - object to test whether they own
&f.haskey [v(d.gf)]=cor(ulocal(f.isowner, %0, %1), cand(isapproved(%0), if(hastype(%1, EXIT), cor(hasattr(loc(%1), _key-%0), hasattr(loc(xget(%1, _exit-pair)), _key-%0)), hasattr(%1, _key-%0))))

@@ %0 - location to get the owners of
&f.get-owners [v(d.gf)]=trim(squish(iter(lattr(%0/_owner-*), if(isapproved(rest(itext(0), -)), rest(itext(0), -)))))

@@ %0 - location to get the key-holders of
&f.get-keys [v(d.gf)]=trim(squish(iter(lattr(%0/_key-*), if(isapproved(rest(itext(0), -)), rest(itext(0), -)))))

@@ %0 - the exit dbref
&f.exit-name [v(d.gf)]=trim(first(name(%0), <))

&tr.error [v(d.gc)]=@pemit %0=ulocal(.error-msg, %1);

&tr.success [v(d.gc)]=@pemit %0=ulocal(.msg, %1);

&tr.remit [v(d.gc)]=@remit case(type(%0), ROOM, %0, where(%0))=ulocal(.remit, %1);

&cmd-+ep [v(d.gc)]=$+ep *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to use this command.; }; @assert cor(isdbref(setr(E, %0)), t(setr(E, trim(squish(iter(lexits(%L), if(strmatch(fullname(itext(0)), *;%0;*), itext(0))))))))={ @trigger me/tr.error=%#, Could not find the exit '%0'.; }; @assert cor(isdbref(setr(P, %1)), t(setr(P, trim(squish(iter(lexits(%L), if(strmatch(fullname(itext(0)), *;%1;*), itext(0))))))))={ @trigger me/tr.error=%#, Could not find the exit '%1'.; }; @assert words(%qE)={ @trigger me/tr.error=%#, More than one exit matches '%0'.; }; @assert words(%qP)={ @trigger me/tr.error=%#, More than one exit matches '%1'.; }; @assert type(%qE)=EXIT, { @trigger me/tr.error=%#, name(%qE) is not an exit.; }; @assert type(%qP)=EXIT, { @trigger me/tr.error=%#, name(%qP) is not an exit.; }; @set %qE=_exit-pair:%qP; @set %qP=_exit-pair:%qE; @parent %qE=[v(d.exit-parent)]; @parent %qP=[v(d.exit-parent)]; @chown %qE=[v(d.grid-owner)]; @chown %qP=[v(d.grid-owner)]; @set %qE=INHERIT; @set %qP=INHERIT; @trigger me/tr.success=%#, strcat(name(%qE) (%qE) has been linked to, %b, name(%qP) (%qP).);

&cmd-+ep_single [v(d.gc)]=$+ep *:@break strmatch(%0, *=*)={}; @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to use this command.; }; @assert cor(isdbref(setr(E, %0)), t(setr(E, trim(squish(iter(lexits(%L), if(strmatch(fullname(itext(0)), *;%0;*), itext(0))))))))={ @trigger me/tr.error=%#, Could not find the exit '%0'.; }; @assert words(%qE)={ @trigger me/tr.error=%#, More than one exit matches '%0'.; }; @assert type(%qE)=EXIT, { @trigger me/tr.error=%#, name(%qE) is not an exit.; }; @assert t(setr(P, xget(%#, _exit-pairing)))={ @set %#=_exit-pairing:%qE; @parent %qE=[v(d.exit-parent)]; @chown %qE=[v(d.grid-owner)]; @set %qE=INHERIT; @trigger me/tr.success=%#, strcat(name(%qE) (%qE) waiting to be paired.); @tel %#=loc(%qE); }; @force %#=+ep %qE=%qP; @wipe %#/_exit-pairing;

&cmd-+owners [v(d.gc)]=$+owner*:@break strmatch(%0, */*)={ @assert switch(%0, /add *, 1, /remove *, 1, s/clean, 1, 0)={ @trigger me/tr.error=%#, Did you mean one of the following commands: +owner/add%, +owner/remove%, or +owners/clean?; }; }; @assert t(setr(T, switch(%0, s *, rest(%0),, loc(%#), %bhere, loc(%#), s, loc(%#), trim(%0))))={ @trigger me/tr.error=%#, Couldn't figure out what you meant by '%0'.; }; @assert t(case(1, isdbref(%qT), setr(R, %qT), match(%qT, here), setr(R, loc(%#)), setr(R, search(ROOMS=%qT))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qT' doesn't make sense.; }; @assert eq(words(%qR), 1)={ @trigger me/tr.error=%#, More than one room matched '%qT'.; }; @pemit %#=ulocal(layout.owners, %#, %qR);

&cmd-+view/owners_here [v(d.gc)]=$+view here/own*:@force %#=+owners;

&cmd-+view/owners [v(d.gc)]=$+view own*:@force %#=+owners;

&cmd-+owner/add [v(d.gc)]=$+owner/add *:@assert t(switch(%0, here=*, setr(R, loc(%#)), *=*, setr(R, first(%0, =)), setr(R, loc(%#))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cand(t(switch(%0, *=me, setr(T, %#), me, setr(T, %#), *=*, setr(T, rest(%0, =)), setr(T, %0))), t(setr(P, pmatch(%qT))))={ @trigger me/tr.error=%#, Could not find a player named '%qT'.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '[first(%0, =)]'.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to add another owner to the owners list.; }; @assert not(isstaff(%qP))={ @trigger me/tr.error=%#, moniker(%qP) is staff. You can't change staff's permissions.; }; @assert not(u(f.isowner, %qP, %qR))={ @trigger me/tr.error=%#, moniker(%qP) is already an owner of [name(%qR)].; }; @assert isapproved(%qP)={ @trigger me/tr.error=%#, name(%qP) is not approved and cannot be made an owner.; }; @chown %qR=[v(d.grid-owner)]; @set %qR=_owner-%qP:[moniker(%qP)] was added by [moniker(%#)] on [time()]; @wipe %qR/view-owner; &view-owners %qR=This location has owners. Use +owners to view them.; @set %qR=_owner-log:[strcat(xget(%qR, _owner-log), %b, moniker(%qP) (%qP) added as an owner on, %b, time(), %b, by, %b, moniker(%#) %(%#%).)]; @cemit [v(.emit_channel)]=[strcat(moniker(%qP) (%qP) has been added as an owner of, %b, name(%qR) (%qR), %b, by, %b, moniker(%#) %(%#%).)]; @trigger me/tr.success=%#, strcat(moniker(%qP) (%qP) has been added as an owner of, %b, name(%qR) (%qR).);

&cmd-+owner/remove [v(d.gc)]=$+owner/remove *:@assert t(switch(%0, here=*, setr(R, loc(%#)), *=*, setr(R, first(%0, =)), setr(R, loc(%#))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cand(t(switch(%0, *=me, setr(T, %#), me, setr(T, %#), *=*, setr(T, rest(%0, =)), setr(T, %0))), t(setr(P, pmatch(%qT))))={ @trigger me/tr.error=%#, Could not find a player named '%qT'.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '[first(%0, =)]'.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to add another owner to the owners list.; }; @assert u(f.isowner, %qP, %qR)={ @trigger me/tr.error=%#, moniker(%qP) is not currently an owner of [name(%qR)].; }; @assert not(isstaff(%qP))={ @trigger me/tr.error=%#, moniker(%qP) is staff. You can't change staff's permissions.; }; @wipe %qR/_owner-%qP; @switch/first words(ulocal(f.get-owners, %qR))=0, { @wipe %qR/view-owner*; }; @set %qR=_owner-log:[strcat(xget(%qR, _owner-log), %b, moniker(%qP) (%qP) removed as an owner on, %b, time(), %b, by, %b, moniker(%#) %(%#%).)]; @cemit [v(.emit_channel)]=[strcat(moniker(%qP) (%qP) has been removed as an owner of, %b, name(%qR) (%qR), %b, by, %b, moniker(%#) %(%#%).)]; @trigger me/tr.success=%#, strcat(moniker(%qP) (%qP) has been removed from the owners list of, %b, name(%qR) (%qR).);

&cmd-+owners/clean [v(d.gc)]=$+owners/clean:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to clean up the owners list.; }; @trigger me/tr.clean-owners=%#;

&tr.clean-owners [v(d.gc)]=@dolist search(eroom=t(lattr(##/_owner-#*)), 2)={ @trigger me/tr.clean-room=%0, ##; }

&tr.clean-room [v(d.gc)]=@dolist lattr(%1/_owner-#*)={ @assert not(isapproved(setr(P, edit(##, _OWNER-,)), approved)); @wipe %1/_owner-%qP; @switch/first words(ulocal(f.get-owners, %1))=0, { @wipe %1/view-owner*; }; @set %1=_owner-log:[strcat(xget(%1, _owner-log), %b, moniker(%qP) (%qP) removed as an owner on, %b, time(), %b, by, %b, moniker(%0) %(%0%).)]; @cemit [v(.emit_channel)]=[strcat(moniker(%qP) (%qP) has been removed as an owner of, %b, name(%1) (%1), %b, by, %b, moniker(%0) %(%0%).)]; @trigger me/tr.success=%0, strcat(moniker(%qP) (%qP) has been removed from the owners list of, %b, name(%1) (%1).); }

&cmd-+keys [v(d.gc)]=$+key*:@break strmatch(%0, */*)={ @assert switch(%0, /give *, 1, /take *, 1, 0)={ @trigger me/tr.error=%#, Did you mean one of the following commands: +key/give or +key/take?; }; }; @assert t(setr(T, switch(%0, s *, rest(%0),, loc(%#), %bhere, loc(%#), s, loc(%#), trim(%0))))={ @trigger me/tr.error=%#, Couldn't figure out what you meant by '%0'.; }; @assert t(case(1, isdbref(%qT), setr(R, %qT), match(%qT, here), setr(R, loc(%#)), setr(R, search(ROOMS=%qT))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qT' doesn't make sense.; }; @assert eq(words(%qR), 1)={ @trigger me/tr.error=%#, More than one room matched '%qT'.; }; @pemit %#=ulocal(layout.keys, %#, %qR);

&cmd-+key/give [v(d.gc)]=$+key/give *:@assert t(switch(%0, here=*, setr(R, loc(%#)), *=*, setr(R, first(%0, =)), setr(R, loc(%#))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cand(t(switch(%0, *=me, setr(T, %#), me, setr(T, %#), *=*, setr(T, rest(%0, =)), setr(T, %0))), t(setr(P, pmatch(%qT))))={ @trigger me/tr.error=%#, Could not find a player named '%qT'.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '[first(%0, =)]'.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to give someone a key.; }; @assert not(u(f.haskey, %qP, %qR))={ @trigger me/tr.error=%#, moniker(%qP) already has a key to [name(%qR)].; }; @assert isapproved(%qP)={ @trigger me/tr.error=%#, name(%qP) is not approved and cannot be given a key.; }; @chown %qR=[v(d.grid-owner)]; @set %qR=_key-%qP:[moniker(%qP)] (%qP) was given a key by [moniker(%#)] on [time()]; @trigger me/tr.success=%#, strcat(moniker(%qP) (%qP) has been given a key to, %b, name(%qR) (%qR).);

&cmd-+key/take [v(d.gc)]=$+key/take *:@assert t(switch(%0, here=*, setr(R, loc(%#)), *=*, setr(R, first(%0, =)), setr(R, loc(%#))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cand(t(switch(%0, *=me, setr(T, %#), me, setr(T, %#), *=*, setr(T, rest(%0, =)), setr(T, %0))), t(setr(P, pmatch(%qT))))={ @trigger me/tr.error=%#, Could not find a player named '%qT'.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '[first(%0, =)]'.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to take away someone's key.; }; @assert u(f.haskey, %qP, %qR)={ @trigger me/tr.error=%#, moniker(%qP) does not currently have a key to [name(%qR)].; }; @wipe %qR/_key-%qP; @trigger me/tr.success=%#, strcat(moniker(%qP) (%qP) has lost their key to, %b, name(%qR) (%qR).);

&cmd-+lock [v(d.gc)]=$+lock *:@assert cor(isdbref(setr(E, %0)), t(setr(E, trim(squish(iter(lexits(%L), if(strmatch(fullname(itext(0)), *;%0;*), itext(0))))))))={ @trigger me/tr.error=%#, Could not find the exit '%0'.; }; @assert words(%qE)={ @trigger me/tr.error=%#, More than one exit matches '%0'.; }; @assert type(%qE)=EXIT, { @trigger me/tr.error=%#, name(%qE) is not an exit.; }; @assert t(setr(P, xget(%qE, _exit-pair)))={ @trigger me/tr.error=%#, name(%qE) is not set up to be locked.; }; @assert cor(u(f.haskey, %#, %qE), u(f.haskey, %#, %qP))={ @trigger me/tr.error=%#, You must have a key to lock the doors.; }; @assert not(t(lock(%qE/DefaultLock)))={ @trigger me/tr.error=%#, name(%qE) is already locked.; }; &_lock-exit %qE=[xget(v(d.exit-parent), d.default-lock)]; @lock/DefaultLock %qE=_lock-exit/1; &_lock-exit %qP=[xget(v(d.exit-parent), d.default-lock)]; @lock/DefaultLock %qP=_lock-exit/1; @trigger me/tr.success=%#, strcat(You just locked, %b, u(f.exit-name, %qE).);

&cmd-+unlock [v(d.gc)]=$+unlock *:@assert cor(isdbref(setr(E, %0)), t(setr(E, trim(squish(iter(lexits(%L), if(strmatch(fullname(itext(0)), *;%0;*), itext(0))))))))={ @trigger me/tr.error=%#, Could not find the exit '%0'.; }; @assert words(%qE)={ @trigger me/tr.error=%#, More than one exit matches '%0'.; }; @assert type(%qE)=EXIT, { @trigger me/tr.error=%#, name(%qE) is not an exit.; }; @assert t(setr(P, xget(%qE, _exit-pair)))={ @trigger me/tr.error=%#, name(%qE) is not set up to be locked.; }; @assert cor(u(f.haskey, %#, %qE), u(f.haskey, %#, %qP))={ @trigger me/tr.error=%#, You must have a key to unlock the doors.; }; @assert t(lock(%qE/DefaultLock))={ @trigger me/tr.error=%#, name(%qE) is already unlocked.; }; @wipe %qE/_lock-exit; @unlock/DefaultLock %qE; @wipe %qP/_lock-exit; @unlock/DefaultLock %qP; @trigger me/tr.success=%#, strcat(You just unlocked, %b, u(f.exit-name, %qE).);

&cmd-+view/set [v(d.gc)]=$+view/set *=*:@assert t(switch(%0, here/*, setr(R, loc(%#)), */*, setr(R, first(%0, /)), setr(R, loc(%#))))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cand(t(switch(%0, */*, setr(T, rest(%0, /)), setr(T, %0))), valid(attrname, setr(T, strcat(view-, edit(%qT, %b, _)))))={ @trigger me/tr.error=%#, '%qT' is not a valid view title.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '[first(%0, /)]'.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to add +views.; }; @assert not(strmatch(%qT, own*))={ @trigger me/tr.error=%#, '%qT' is too similar to 'owner'. You can't use it as a view title because it might confuse people.; }; @set %qR=%qT:[setq(O, xget(%qR, %qT))]%1; @trigger me/tr.success=%#, strcat(You have, %b, case(%1,, removed, if(t(%qO), updated, created)), %b, a +view on, %b, name(%qR) (%qR), %b, called, %b, ', titlestr(edit(%qT, view-,, _, %b, ~, %b)), '., if(t(%qO), strcat(%b, The old text was:, %b, %qO)));

@set [v(d.gc)]/cmd-+view/set=no_parse

&cmd-+view/add [v(d.gc)]=$+view/add *=*:@force %#=+view/set %0=%1;

&cmd-+view/remove [v(d.gc)]=$+view/remove *:@force %#=+view/set %0=;

&cmd-+desc [v(d.gc)]=$+desc *=*:@assert t(switch(%0, here, setr(R, loc(%#)), setr(R, %0)))={ @trigger me/tr.error=%#, Could not figure out what room you're referring to. '%qR' doesn't make sense.; }; @assert cor(isdbref(%qR), t(setr(R, search(ROOMS=%qR))))={ @trigger me/tr.error=%#, Could not find a room named '%qR'.; }; @assert words(%qR)={ @trigger me/tr.error=%#, More than one room matches '%0'.; }; @assert t(%1)={ @trigger me/tr.error=%#, You must include a description.; }; @assert u(f.isowner, %#, %qR)={ @trigger me/tr.error=%#, You must be an owner of [name(%qR)] to edit the description.; }; @set %qR=desc:[setq(O, xget(%qR, desc))]%1; @trigger me/tr.success=%#, strcat(You have updated the description on, %b, name(%qR) (%qR). The old text was:, %b, %qO); @trigger me/tr.remit=%qR, moniker(%#) has updated the description of this room.;

@set [v(d.gc)]/cmd-+desc=no_parse
