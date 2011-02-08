#!/usr/bin/env ruby

fix_commit("7de5133262d5d6072a3fda6458fe9075aa7e4bc4", "Unknown <unknown>")

fix_commit("2d6f9e6fefcb1cc3acf077976fb4563ec6195f82", "Tomáš Kebert <unknown>")
fix_commit("e8b2e1e7ac4597ec67db53c64064e2e8e7f3cbc1", "Tomáš Kebert <unknown>")

fix_commit("73e463add9a124c86554c2958526e1a6ee5fc22f") do
<<EOF
A patch from Jorge Villaseñor which makes all pounces share a single window.
The window is based on the one used by the mail notifications.

I made some extra changes on top of the patch to clean things up a little bit,
mainly to improve strings.  Blame me if something breaks!

Thanks to bjlockie for helping with testing.  Closes #190.
EOF
end

fix_commit("5f09af339b347a053147a84eb45b9e47b518e5bd") do
<<EOF
[gaim-migrate @ 15603]
SF patch 1411796 by Andrej Krivulčík

It adds a /role command to jabber chat rooms.
EOF
end

fix_commit("69ca65a19d58168311263e62480f7f6e05ec29c7") do
<<EOF
Clean up a few comments, changing from C++ style to C-style if needed, and add a
few comments with associated ticket #s if applicable.

Also, call msim_unrecognized() if unknown status types are received, and use
#defines for msim_error() codes. General cleanup.
EOF
end

fix_commit("2c70b0a3d94cceda2826edc93fac5566775bab35") do
<<EOF
Patch from Jaywalker to show error messages inline with an IM window, if
possible, instead of as a popup. Now if you IM a non-existent user, you'll get a
"No such user: xxx" message inside the IM window instead of as a popup, for
example.

Closes #4687.
EOF
end

fix_commit("edd672a79a29dc97a942d9520e7a3b93519af9d4") do
<<EOF
In msimprpl, change msim_get_contact_list() to not cause an assertion failure if
the user has no friends (poor user), indicated by the absence of body.
EOF
end

fix_commit("b8c613f6120f38c693118573e89ea1a032781b31") do
<<EOF
Change msim_uid2username_from_blist to accept a PurpleAccount instead of an
MsimSession, and change msim_normalize() so that it can normalize accounts that
are not yet signed on. It can do this because libpurple stores an offline buddy
list.
EOF
end

fix_commit("a857dad496ca139ff4186c0d4df282cecd7c371f") do
<<EOF
Fix incorrect indentation (use tabs instead of spaces) because of an
incorrectly-configured editor (and fix my editor settings).
EOF
end

fix_commit("5cfc19787cb16932e5e50c4034a7c46699fe1c51") do
<<EOF
Add stubs and comments for group chat commands, a start of #4691.
EOF
end

fix_commit("0c2f544829df2f3a369504315f8b3a6cc325749a") do
<<EOF
Timeout switchboard connections at 60 seconds, should Fixes #3330 for most
people.  Thanks to the msn-pecan project for this idea.
EOF
end

fix_commit("0cc6fa10027bf829296dc524792add070c70f8eb") do
<<EOF
AIM Direct IM messages should not be flagged as auto responses unless they
actually are. Plucked 0cc6fa10 from im.pidgin.adium.
EOF
end

fix_commit("155eaff66198bb519898da8e7071925567efc279") do
<<EOF
Fix what looks like an incorrect merge that caused gevolution's add buddy dialog
to segfault.

UPDATE:

Fix reversed logic in the gevolution plugin that led to a crash. Fixes #10115.
EOF
end

fix_commit("18b0a096bd6f21011f16c7b08c1aac016d2c0fff") do
<<EOF
disapproval of revision 'abf01263a12b500f0217fd8c62921fa1030fa1c2'

Revert the pluckings, since I overloaded and couldn't refix. Time to take it
slow.
EOF
end

fix_commit("25026f5a4434830bb15c2235e8a35f13d2de3157") do
<<EOF
BOSH: For authentication purposes, HTTPS is equivalent to a secured JabberStream.

Since we always require the connection from CM to server to be secure, allow
BOSH+HTTPS to pass 'Require SSL/TLS'.

Also, stop leaking a file descriptor in http_connection_disconnected.
EOF
end

fix_commit("2cf653f0a15b26dd7936e8823786dcff52df3526") do
<<EOF
propagate from branch 'im.pidgin.pidgin' (head da2f4b4aea9c7f3e28c13f28b1ec087d4f589f25)
            to branch 'im.pidgin.adium.1-4' (head cef4d764b52e204f7a8a38a75fc3d464dfce7ec9)

propagate from branch 'im.pidgin.pidgin' (head da2f4b4aea9c7f3e28c13f28b1ec087d4f589f25)
            to branch 'im.pidgin.adium' (head cef4d764b52e204f7a8a38a75fc3d464dfce7ec9)
EOF
end

fix_commit("331937f46235852e1813a1492eb351071127e02c") do
<<EOF
Fixed an errant comment
EOF
end

fix_commit("4202c0b7bf87baabeb41ab62235e573f12265f26") do
<<EOF
Updated Albanian translation.

Closes #10177.
EOF
end

fix_commit("4332f4fcb2cf764aa2534891346eb29c326ab57a") do
<<EOF
Do not disable default smileys with dupliate shortcuts if custom smileys
are not supported by the prpl. Also, show the text of the disabled smiley
in the tooltip.

And use _prepend and _reverse, instead of _append for GLists, since some
people apparently have hundreds of custom smileys.

Closes #6057.
EOF
end

fix_commit("4dcf57d47a73223c7c72ea9404107b71d7daac4f") do
<<EOF
Send XMPP keepalive pings to our server, not our bare JID.

jabberd doesn't seem to follow the same semantics for a missing/empty 'to' on a
stanza; the response comes from our own full JID. Addressing the pings to the
server's JID should sidestep that problem.
EOF
end

fix_commit("768a62d29a0b004bea9c9265d4fc810558c0242a") do
<<EOF
disapproval of revision '23fc27a319dd87434fdaf42acecbe1962468bbb8'

This causes issues with some XMPP smileys.  Namely, :-P and :-p, but not :p and
:P (among others).
EOF
end

fix_commit("853ef8a304909716698b82fe56f7e96b2af64c98") do
<<EOF
Start converting PurpleConnection into a GObject with proper struct hiding.
libpurple itself and plugins/ compile. But there are a lot of compile errors in
protocols/. I hope to get to them in a night or two.

This commit includes a lot of changes from an earlier commit by grim.
EOF
end

fix_commit("8f3c22382fdd3b6c4a0a3d29e4052c1b2138303a") do
<<EOF
"The labels for the preferences in the contact priority plugin have the
standard alignment "center". This doesn't look nice. I saw, that other
preferences in the preference window are aligned left/up. The patch
changes the alignment to left/up." -- Bjoern Voigt

being consistent is a good thing :-)
EOF
end

fix_commit("914a150e0946a7b03298e5a93bf322f2e869e47a") do
<<EOF
Don't track a cb-per-POST and remove the PurpleHTTPResponse structure.

The only callback ever used is http_received_cb and the ordering of
responses from the server is not guaranteed to match the order of our requests,
so the metaphor of matching them doesn't make sense. Instead of that, just
track the number of requests (to ensure there is always a request outstanding).

Additionally, pass the data const-ified instead of copying it. It's just
fed to an XML parser anyway.

UPDATE:

Tobias pointed out my explanation was flat-out wrong. The server's replies *do*
correspond to a specific request (HTTP pipelining). I believe what I meant to
say is that the XML in the replies isn't guaranteed to correspond to the
request's payload.

In any event, the critical point is that the callback is always the same, so
there's no need to store it per-request.
EOF
end

fix_commit("9773a5b5ab5a0d5eb32c8fa8277ee7f5d636fdac") do
<<EOF
merge of '26a511ef6be2c20a09d0fd93527980c97169c67e'
     and 'f44067bee9c00d12f10b7bd4635f6240935bb18e'
EOF
end

fix_commit("a4ba04d007c334f8f7304c5d953d6ac8084e970e") do
<<EOF
disapproval of revision '1f819f5ad330efa81ac7906f854b46f0c8bbd7b6'
EOF
end

fix_commit("a58225b22301de0a19852b59dcd09a66017d8e0e") do
<<EOF
Prevent the Buddy State Notification plugin from printing duplicate
notifications when the same buddy is in multiple groups on protocols which
support it.  Also prevent autolinkification of JID's, MSN passport addresses,
etc. in the notification messages.  Fixes #7609.
EOF
end

fix_commit("afe2ae57083c4e8da50615930fcb9adca74cb908") do
<<EOF
Patch from Marcus Lundblad ('mlundblad') to improve audio support in xmpp.
It's now possible to initiate an audio session, sometimes. It's somewhat
buggy.
Some other issues also need to be resolved:
 * Properly get rid of the compile warnings
 * Rename the serv_ functions with proper namespacing.
 * Possibly rename the purple_media_ functions that don't deal with a
   PurpleMedia (e.g. purple_media_audio_init_src) to something different,
   e.g. purple_media_util_, or even purple_gst_util etc.

References #34.
EOF
end

fix_commit("bcfb665250821266c993e2f5818c4e3f65314ff4") do
<<EOF
Patch from 'goutnet': Pressing backspace on a smiley will replace the smiley
with its text. Pressing backspace again will behave as it would for normal text.
References #3286.
EOF
end

fix_commit("d61c2fc82b19cd2629b498d903d7018d41a00108") do
<<EOF
disapproval of revision 'c1eb11b61c6c6756eba2e3aa380e4e4e09db0914'

Disable the prefs unint changes for now because they are problematic. Refs #7761.

disapproval of revision 'c1eb11b61c6c6756eba2e3aa380e4e4e09db0914'

Re-enable the prefs unint changes. Refs #7661.
EOF
end

fix_commit("dd58d6e08f6bf88e8bdd13e3c8d0b73cc73bbab3") do
<<EOF
disapproval of revision '59dabca54f8fec54f44c38eaaaafb29086c7ade7'

Disable the prefs unint changes for now because they are problematic. Refs #7761.

disapproval of revision '59dabca54f8fec54f44c38eaaaafb29086c7ade7'

Re-enable the prefs unint changes. Refs #7661.
EOF
end

fix_commit("fb9ec433650ff4b1b7f84319be7937cb6ab45e71") do
<<EOF
disapproval of revision '872f027c46dce251e1ce50a76817a0d7c609147d'

A temporary branch to fix a naming mess.
EOF
end

fix_commit("fec5cf492996c95ddbd5c1405b30d8f06a78f806") do
<<EOF
This patch from Thanumalayan S. implements Yahoo protocol version 15 file
transfer support.  Currently sending multiple files from an official Yahoo
client is treated as multiple individual transfers that must be accepted
separately.  This also changes things so that we identify as Yahoo Messenger
version 8.0 (previously we were identifying as 6.0 or not at all).
Refs #708.  Refs #4533
EOF
end
