From: nobodyless@gmail.com (_nobody_ _nobody_)
Date: Mon, 29 Jan 2018 09:54:20 +0100
Subject: [cip-dev] Releasing draft of private GitHub cip-b_at_d-generic repo
Message-ID: <CABpTzB1LeLyMZRVuFo=cAvHgA6-dAcwpjvSMk2ma4LziLeu=6Q@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello to the CIP Community,

Here is the first release of my private copy of well known GitLab
board-at-desk-single-dev (I found it also on GitHub:
https://github.com/cip-testing/board-at-desk-single-dev).

The web pointer to it: https://github.com/ZoranStojsavljevic/cip-b_at_d-generic

There are few reasons why I have decided to clone it to my own private
repo (cip-b_at_d-generic):
https://github.com/ZoranStojsavljevic/cip-b_at_d-generic. One of them
is that I everyday try to fix and enhance this repo, so no time to
communicate each and every small change to the community, since it is
very time consuming. The other reason is that I experiment with th new
releases of the Fedora (host I am using) and RubyGem packages, so I
also added to the repo the new Vagrantfile script for the --provider
libvirt, as experimental release, which is, as by the time I write
this email, still very unstable (and port forwarding, for some to me
unknown reason, does not work yet). This is aside project I am doing,
outsile of the hours, which are dedicated for the --provider
VirtualBox testing (as initially intended).

Let me do the brief explanation what are the files in the root of the projects:

importbox.sh.genesis <<======= original script for the reference
importbox.sh <<============= modified script which replaces original
one, serving to two providers
info_vbox.sh <<============= sync script which gives exact global
status of the whole system, for both Virtual Boxes and Vagrant,
managing Virtual Boxes
Vagrantfile.libvirt <<========== generic vagrant --provider libvirt
Vagrantfile config [experimental phase presently]
Vagrantfile.virtualbox <<======= generic vagrant --provider virtualbox
Vagrantfile config

Please, do note the following: both Virtual Box and libvirt are NOT
aware that there is client above them, managing them, in other words,
vagrant has one way relations with providers, so things can very
easily slip out of sync.

The another important thing done here is strategy called: "divide and
conquer", since I decided to manage one provider pre one Vagrantfile
config (Hashicorp promised long time ago to have more than one
provider in single Vagrantfile seamlessly working, but this is NOT, so
far (and still far away, seems) achieved, so upon splitting the
providers (only two so far) some of the vagrant instabilities went
away).

Do not forget, vagrant ALWAYS manages Virtual Box first, then takes on
other providers (if it does detect them in Vagrantfile).

>From today I'll concentrate to start adding some more scripts into
Virtual Box part, to make CIP testing more integrated. It will be done
also using this/my repo, since all of this is not yet rock solid
proven (me and Robert Marshall can later agree what makes sense to
integrate to the main CIP testing project).

All the suggestions, addendums, criticism, improvements etc. will be
carefully considered. Please, do not hesitate to take the action, ask
questions (if anything unclear, buggy, etc.) since any input is very
welcome!

Thank you all,
Zoran Stojsavljevic
