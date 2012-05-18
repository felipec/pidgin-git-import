#!/usr/bin/env ruby
# encoding: utf-8

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

fix_commit("cbff5094920653b96fd8752191cf581b9fa79846") do
<<EOF
Add stubs and comments for group chat commands, a start of #4691.
EOF
end

fix_commit("5cfc19787cb16932e5e50c4034a7c46699fe1c51") do
<<EOF
In msimprpl, grow the read buffer if it gets full using g_realloc(), similar to
how the IRC prpl does it. Now large messages should be received and processed
without filling up the read buffer and crashing.
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
[gaim-migrate @ 8044]
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

fix_commit("2e0abd0eb95d9d698eaaa557b021794f2d858620") do
<<EOF
ChangeLog by nosnilmot@pidgin.im:
Remove an old string that became a dupe in the big sed of 2009

ChangeLog by rekkanoryo@pidgin.im:
Fix a duplicate string khc found that came about as a result of fixing up the
references to our old name in all the translations.
EOF
end

fix_commit("7252a43314152ad33cc6dc4d65c0349a16575b81") do
<<EOF
ChangeLog by resiak@soc.pidgin.im:
Patch from nix_nix to add some links to signal documentation.

Fixes #3462.

ChangeLog by nix@go-nix.ca:
Adding dox references to the various signals pages
EOF
end

fix_commit("748e70b43d9e828a79f3c72c9fbe484f9e893dbd") do
<<EOF
ChangeLog by grim@pidgin.im:
Patch from Eoin Coffey to install the mono loader into the correct directory.

ChangeLog by ecoffey@soc.pidgin.im:
Fixed installation of mono.so and PurpleAPI.dll
EOF
end

fix_commit("8a14c1d90381baa3c31adeedee7f673d58d66304") do
<<EOF
disapproval of revision 'abcb63937b0282df910bc35d286c3f0d3245bfa5'
EOF
end

fix_commit("20182b8a724ad25a76a75fde895ad9d500926002") do
<<EOF
[gaim-migrate @ 15629]
Patch from Björn Voigt

This silences a warning when running intltool-update -m.
EOF
end

fix_commit("20850e3ae7d5e8eb0bb748d86ff5b30fc897d7bd") do
<<EOF
[gaim-migrate @ 14801]
A few minor string changes.  Some from Björn Voigt.  Yaaaayyy Björn.
EOF
end

fix_commit("288096d320924c332de6d12dbfccd77112b49d6b") do
<<EOF
[gaim-migrate @ 15451]
Various i18n improvements from Björn Voigt
EOF
end

fix_commit("29356683ef1c4295893f3d2a1c3bfb7d703cfcdb") do
<<EOF
[gaim-migrate @ 12481]
sf patch #1180138, from Vajna Miklós
Add a Hungarian translation of the gaim.desktop file.  I'm not
sure who actually translated this.
EOF
end

fix_commit("2eb8ea846d0fee4ca8594dd317914793452aff45") do
<<EOF
[gaim-migrate @ 15850]
Fix a warning:

gtkrequest.c: In function "generic_response_start":
gtkrequest.c:84: warning: unused variable "cursor"
EOF
end

fix_commit("34bcbf7bfae02f219097f607ce06183334f1778f") do
<<EOF
[gaim-migrate @ 16003]
A patch from Björn Voigt to implement an error notification when a user search fails.
EOF
end

fix_commit("3511bea0bbd5d7607d5d9cdf1beac99a730b6192") do
<<EOF
[gaim-migrate @ 13438]
Patch #125770 from Steve Láposi

"In gaim-intaller.nsi the default GTK install path contains the string "Common Files". With non-default MSWindows installs that is maybe not the correct location."

I haven't tested this, but it looks good. :)

(I seem to be seeing encoding issues with the COPYRIGHT file in oldstatus, so I don't know if this is going to work.)
EOF
end

fix_commit("4047fd5fd13c47073c288b68c46b15037c40ead6") do
<<EOF
[gaim-migrate @ 10359]
Fix bug 988882, submitted by Björn Voigt.
He also submitted a patch, but I like my way better.
Anyhoo, thanks Björn.

Also committing some notes to myself because I'm too
lazy to remove them and THEN commit.
EOF
end

fix_commit("42986a6e06357b90e6b5d39f86fedf2b2af62211") do
<<EOF
[gaim-migrate @ 12596]
Fix Fedora "Bug" 149767 -- gaim plugins unresolved symbols
EOF
end

fix_commit("465c193e5cec70fbd8299ad57f18b402fa0a9bb5") do
<<EOF
[gaim-migrate @ 14594]
Patch from Björn to translate the plugin name in plugin
configuration windows
EOF
end

fix_commit("46620a690da6896ffa052f2b7c93fef9ffd8ab5d") do
<<EOF
[gaim-migrate @ 15950]
SF Patch #1458542 from Björn Voigt

This adds a couple missing translation markers and fixes the case of a
string in oscar.c.
EOF
end

fix_commit("47b884934a8154311513ed070b074d7e0b2dff80") do
<<EOF
[gaim-migrate @ 15755]
A patch sent to gaim-i18n from Björn Voigt:

'I agree with Danilo that we do not need the "property description" i18n
 strings in the imported GTK+ files.

 My attached patch changes the _() markers to P_() markers in
 gtkcellview.c and gtkcombobox.c. The file already had P_() markers. The
 files gtkcelllayout.c and gtkcellviewmenuitem.c do not have i18n strings.'
EOF
end

fix_commit("4b441aa169302bd202cc3864071d95719aa596a5") do
<<EOF
[gaim-migrate @ 15982]
Björn brought to my attention that we're missing the name of one of the Kurdish translators in the Help->About box.
EOF
end

fix_commit("4b6ea3be0a6f86af5638beefb2b134fb507c5262") do
<<EOF
[gaim-migrate @ 15639]
Patch from Björn Voigt to add src/protocols/bonjour/jabber.c to POTFILES.in
EOF
end

fix_commit("4d0bb34a2c7d756709543114a60fc3dc79f6a460") do
<<EOF
[gaim-migrate @ 4619]
application should not exit when the login/main window is closed if the docklet is loaded...
Thanks, Nicolás Lichtmaier (niqueco)
EOF
end

fix_commit("530f2b66900f6b02a33a2d40a64366b533bc8757") do
<<EOF
Index: buddy.c
===================================================================
RCS file: /cvsroot/gaim/gaim/src/buddy.c,v
retrieving revision 1.484
retrieving revision 1.485
diff -u -d -r1.484 -r1.485
--- buddy.c     2 Apr 2003 06:32:53 -0000       1.484
+++ buddy.c     2 Apr 2003 23:38:30 -0000       1.485
@@ -1137,7 +1137,7 @@
 
        gtkblist->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        gtk_window_set_role(GTK_WINDOW(gtkblist->window), "buddy_list");
-       gtk_window_set_title(GTK_WINDOW(gtkblist->window), _("Biatches List"));
+       gtk_window_set_title(GTK_WINDOW(gtkblist->window), _("Buddy List"));
        gtk_widget_realize(gtkblist->window);
 
        gtkblist->vbox = gtk_vbox_new(FALSE, 0);






















































































































































































































really
EOF
end

fix_commit("5b0882ab2c19e70051774435cb418ae49850bc20") do
<<EOF
<Robot101> commit message:
<Robot101> wait
<Robot101> don't apply that
<Robot101> bloody gedit
<Robot101> there we go
<Robot101> fixed it
<Robot101> patch to fix docklet crash on unload, thanks to Nicol�s
           Lichtmaier for identifying the problem and fix, and
           Kristian Rietveld for implementing it
<Robot101> also implements a blinking icon when messages are pending &
           credits people correctly in ChangeLog
<Robot101> and for the record, it was Nicol�s Lichtmaier who did the
           icon factory stuff last night
           * Robot101 hops up and down
<Robot101> patchy merge merge!
< ChipX86> fine.
<Robot101> yay =)
EOF
end

fix_commit("5b52451311c9ea0091b69f41d69fb555786aaf7e") do
<<EOF
[gaim-migrate @ 15924]
Björn Voigt found two untranslated strings.
EOF
end

fix_commit("5d762e1020b641dbd1c4747188f9051ef7b3a18a") do
<<EOF
[gaim-migrate @ 16002]
Patch from Björn Voigt on gaim-i18n to translate the search instructions that come from the Jabber server. He's provided the string for users.jabber.org, the most common case.

This technique is a bit of a hack, but it seems like the best option we've got at the moment. I said I'd commit this as long as nobody objected.

Also, there's a fix here in case xmlnode_get_data(instnode) returns NULL.
EOF
end

fix_commit("5f09af339b347a053147a84eb45b9e47b518e5bd") do
<<EOF
[gaim-migrate @ 15603]
SF patch 1411796 by Andrej Krivulčík

It adds a /role command to jabber chat rooms.
EOF
end

fix_commit("6df20814128217d37a4962284319ff388e3c9809") do
<<EOF
[gaim-migrate @ 15952]
Björn pointed out on gaim-i18n that the instructions are not translated.
For users who might not speak English (or whatever language the server
configuration file is in), it seems worthwhile to flag that text as coming
from the server.
EOF
end

fix_commit("6e160d659fc516b5a736d9c23069bbcac7330396") do
<<EOF
[gaim-migrate @ 8296]
Björn Voigt (bjoernv) writes:
" I found a small problem in Gaim's proxy settings. There
is an option "Use Environmental Settings". This option
does not work as expected.

Gaim reads the environment variables http_proxy (or
HTTP_PROXY or HTTPPROXY) and http_proxy_port (or
HTTP_PROXY_PORT or HTTPPROXYPORT) and variables for
proxy user and proxy password. Gaim expects the
following format:

export http_proxy=your.proxy.server
export http_proxy_port=8080

As far as I know this is a unusual format. Probably
there is no
standard document, which describes the correct format
of proxy
variables, but browsers like Konqueror, Amaya, Lynx and
others use a pseudo standard format:

export http_proxy="http://your.proxy.server:8080/"

The port number defaults to 80. The variable
http_proxy_port is
unknown. The proxy variable format is described in some
W3C pages, for instance:


http://www.w3.org/Daemon/User/Proxies/ProxyClients.html
http://www.w3.org/Library/User/Using/Proxy.html
http://www.w3.org/Amaya/User/Proxy.html

Solution
--------

My patch fixes the proxy environment variable parsing
in src/proxy.c:1626: gaim_proxy_connect(). The patch
removes
http_proxy_port and uses gaim_url_parse() from
src/util.c to parse the http_proxy variable.

Remaining problems
------------------

If a user has adjusted his proxy settings to Gaim's old
proxy variable format, he gets an error. I don't think,
that this is a big problem, as not much users set their
proxy variables only for one program (old proxy
variables where incompatible with browsers like Lynx,
Konqueror,
...).

Gaim still doesn't look at the no_proxy variable. This
variables
defines hosts and domains, which should be connected
directly:

export
no_proxy="cern.ch,ncsa.uiuc.edu,some.host:8080"

For example, one user may want to connect to Yahoo!
over a proxy and to an internal Jabber server without a
proxy. But the user can define individual proxy
variables for each account."

he continues:
"Nathan Walp <faceprint@faceprint.com> wrote:

> Why not have your patch check to see if the http_proxy var
starts with
> "http://", and if so, parse it, otherwise fall
back on the
old behavior.

Ok, the function gaim_url_parse() automatically detects
hostnames and port numbers, if the http_proxy URL does not
start with http://.

My new patch also checks for http_proxy_port. Now my patch
(file proxy2.patch) is fully backward compatible and tested."

given how rarely the current proxy code works, i don't see how this could
possibly make things worse, so i'm taking a chance since it compiles.
someone please test this.
EOF
end

fix_commit("713060bd15d295076258accf5c2fda057582b5f2") do
<<EOF
[gaim-migrate @ 15825]
gtkblist.c: In function "gtk_blist_menu_showlog_cb":
gtkblist.c:385: warning: unused variable "cursor"
EOF
end

fix_commit("76e0564c3200894e1f1996edd505b80ce7b7f63c") do
<<EOF
[gaim-migrate @ 10781]
" 1017153 crash on exit with message waiting(stacked) on
the systray

added gaim_signal_connect on "quitting" to do the
docklet_flush_queue on quitting instead of plugin
unload if gaim is quitting." --François Gagné

Date: 2004-08-27 17:24
Sender: datallahSourceForge.net Subscriber
Logged In: YES
user_id=325843

This is legitimate and should be applied to cvs, closing
bug# 1017153.

Date: 2004-08-27 17:23
Sender: frenchfrog
Logged In: YES
user_id=1013807

with permission of datallah im posting is (simplier) patch
to the problem.
EOF
end

fix_commit("7a6fbb19390663a9b88e134353e8aa97bde76f17") do
<<EOF
[gaim-migrate @ 13709]
Patch from Steve Láposi so that the version information is displayed if the -v flag is specified and so the single instance stuff doesn't kick in when -v or -h is specified.
EOF
end

fix_commit("80ca3d2de3d47032f0cb36dac6ba62c0a613c292") do
<<EOF
[gaim-migrate @ 13437]
Patch #1257770 from Steve Láposi

"In gaim-intaller.nsi the default GTK install path contains the string "Common Files". With non-default MSWindows installs that is maybe not the correct location."

I haven't tested this, but it looks good. :)
EOF
end

fix_commit("8249ccb64c9300931bfd8c861ae8b5395c233718") do
<<EOF
[gaim-migrate @ 12600]
" The file plugins/docklet/eggtrayicon.c was not
registered in po/POTFILES.in.
src/protocols/rendezvous/rendeszvous.c is still not in
po/POTFILES.in, because it's not used in default
configuration.

I also sorted the entries with

sort -t/ -u -o po/POTFILES.in po/POTFILES.in

Some entries were not sorted in this order. " --Björn Voigt
EOF
end

fix_commit("8d4d0afe83d673675712c3088610675b44777f0b") do
<<EOF
[gaim-migrate @ 10435]
" This patch moves from the localized date format %c to
the ISO date format as the user log does. This makes
logs locale independent." --Eduardo Pérez
EOF
end

fix_commit("9524362ad84950f1a324fd6cf4a460f96bbb07a9") do
<<EOF
[gaim-migrate @ 14279]
Switch to using the unicode character 0x25cf instead of an asterisk as
our password masking character.

In the words of the great Christian Hammond, "By the way, isn't it
about time we replace the asterisk in masked entries with that unicode
character for the round filled circle ("●")? The asterisk is so 1980s."
EOF
end

fix_commit("9ca1ed18963ac1ca8255f8be17dbe5cfb56c0be4") do
<<EOF
[gaim-migrate @ 8309]
Felipe Contreras (aka revo aka shx) writes:
" Basically that, currently gaim will not display
international "subjects" or "from" fields from emails,
like "añña" or "Paúl".

This implements the propper RFC that specify the format
for those fields."
EOF
end

fix_commit("a0688afd272c97d852f2f5012fcdd93ac4a2b502") do
<<EOF
[gaim-migrate @ 12597]
Fix Fedora "Bug" 149767 -- gaim plugins unresolved symbols
EOF
end

fix_commit("aa09b43ce25d9d3d3e4e98a052a4a6594c347ebb") do
<<EOF
[gaim-migrate @ 15880]
Fix the following warning:
gtkconv.c: In function "gtkconv_chat_popup_menu_cb":
gtkconv.c:1631: warning: "return" with no value, in function returning non-void
gtkconv.c:1649: warning: this function may return with or without a value
EOF
end

fix_commit("aa15b092d72e14b53e096aae8ea50d5a21614587") do
<<EOF
[gaim-migrate @ 15194]
A patch from Björn Voigt to make sure the usage info is printed out
in the correct localization:
"There is a small i18n problem in src/gtkmain.c. Unlike Gaim
oldstatus, the new code calls show_usage() before gtk_init_check().
This means that, setlocale() is not called and the usage message is English."
EOF
end

fix_commit("ab64591f57c0e116a8ad84da4e1707aa0ac10260") do
<<EOF
[gaim-migrate @ 15944]
Patch from Björn Voigt to add some missing translation markers.
EOF
end

fix_commit("aba3324ddf2dd590a85026fd1ea7a422a5188df7") do
<<EOF
[gaim-migrate @ 15925]
Another patch from Björn Voigt:
"Jochen Kemnade helped me very much with the German translation for
2.0.0. He wants to continue translation support and asked to be added to
the current translators list."

and

"I found an inconsistency in the translators list. Normally there is only
one translator per line. But there could be more than one translator for
one language. But Erdal Ronahi and Amed Ç. Jiyan are in one line. The
problem is that the click on the mailto-link does not work with two mail
adresses together (in the Gaim->About window)"
EOF
end

fix_commit("ae036dc227b70d1fb1f6ad70cd98cb3b19acf047") do
<<EOF
[gaim-migrate @ 15716]
Javier Fernández-Sanguino Peña sent me these a while back, before we
were using intltool
EOF
end

fix_commit("ae17ca73de1aa444e5c7386d9da83048ebba40a0") do
<<EOF
[gaim-migrate @ 15580]
Björn Voigt noticed there was no more check for setlocale:

"Do you know, why HAVE_SETLOCALE is not available any more? Probably this has something to do with the intltool patch."
EOF
end

fix_commit("aee1e0404272ff70454e80513e2d4f3f008a9236") do
<<EOF
[gaim-migrate @ 12480]
sf patch #1180138, from Vajna Miklós
Add a Hungarian translation of the gaim.desktop file.  I'm not
sure who actually translated this.
EOF
end

fix_commit("b2a4b28a4ba0b18da28e63d5f6f5802e5c40639c") do
<<EOF
[gaim-migrate @ 14306]
sf patch #1167921, from Joao Luís Marques Pinto
"This patch adds the command /nickserv, /chanserv,
/memoserv, /operserv, it is safer than the /msg option
because more modern ircds will ensure that the message
is routed to a service and not to a "fake" client."
EOF
end

fix_commit("ba1ddf349d2c9f3e5df7bd957516f1dfe92ed52a") do
<<EOF
[gaim-migrate @ 4291]
I went ape on ICQ's i18n stuff for offline messages/channel 4 messages.  I'm
pretty sure accented characters and what not should work like a charm, now.
Thanks to Mr. McQueen and Mr. Blanton.  Also, I changed some stuff with handling
these types of messages, so we actually delimit the message at the delimiters.
So, uh, hopefully no one will complain about funky "þ" symbols in their
authorization requests.

Stuff to look out for would be authorization requests and replies not working.
I still haven't been able to get icqnum@pager.icq.com to work reliably enough
to test it.

And also, I'd like to take this moment to say that lobsters are really neat.
Yeah.  Lobsters.
EOF
end

fix_commit("d0318ccc22aee708367efd769ba17abd5c829557") do
<<EOF
[gaim-migrate @ 13588]
Make the stun stuff compile on win32. This is largely untested since this code will not currently ever be called, but it compiles. This is based on a patch from François Gagné."
EOF
end

fix_commit("db31bc9e1191bd292ff9bba684c8970500803e89") do
<<EOF
Some POTFILE.in shuffling and what not from Björn Voigt
EOF
end

fix_commit("dc8671a54d8086b4c6f4bbffe1f9dc227539da7b") do
<<EOF
[gaim-migrate @ 8956]
Smore changes to oscar chat stuff.  Shouldn't be anything noticable.

For some reason when I paste "cómo" followed by some Japanese text
into a chat it isn't received correctly.  I think there is
something weird with the conversation to UCS-2BE, but I'm not
really sure what.
EOF
end

fix_commit("e52f2c7999a4852e29437afdbcb4d1b4e9bbbf89") do
<<EOF
[gaim-migrate @ 10451]
" I added two possible commands to gtk-remote: away and back.
away causes the away dialog to appear with the default
message and sets the status to away, back hides the
dialog and sets the status to online.

To implement this, I added to new CUI packet subtypes:
CUI_USER_AWAY and CUI_USER_BACK. This are processed in
core.c by calling do_away_message and do_im_back,
respectively." --István Váradi
EOF
end

fix_commit("e8c2495b9d819bbdf32d708df52f7e1175cec80b") do
<<EOF
[gaim-migrate @ 9660]
i18n fixes for SILC from Ambrose Li and Éric Boumaour.
EOF
end

fix_commit("ea3d5339608b2a8d3039ec42209d214a6380d8e9") do
<<EOF
[gaim-migrate @ 15146]
Fix a warning
gtkblist.c:2553: warning: missing initializer
gtkblist.c:2553: warning: (near initialization for "blist_menu[15].extra_data")
EOF
end

fix_commit("eac0be9877e6d65fca52ac71c4d155b9e76023fb") do
<<EOF
[gaim-migrate @ 15456]
Updated German translation from Björn Voigt
EOF
end

fix_commit("ee73561d6a7b2f3780258987c62c4901c61a66e4") do
<<EOF
[gaim-migrate @ 15578]
Patch from Björn Voigt:
    * early character set conversation for the segfault message
    * new formating of the English segfault message (URLs are now alone
      on a line with out a trailing dot -  this makes copying of the
      URLs easier)
EOF
end

fix_commit("f4243aec54b0d73b1afaeb739ee50390654de9e6") do
<<EOF
[gaim-migrate @ 4532]
(17:42:36) Robot101: this patch sets up a function we'll need for
session management in the future, which also fixes the bug with the
-f/--file option not being retained for subsequent instances of
Gaim (either when cloning or logging in again), and replaces the
'discard' command with /bin/true for the moment.
(17:43:56) Robot101: thanks to Nicolás Lichtmaier for pointing this
out and inspiring me, also in my last patch he spotted the current
directory wasn't being stored
EOF
end
