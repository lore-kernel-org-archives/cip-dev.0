From: nobodyless@gmail.com (_nobody_ _nobody_)
Date: Thu, 11 Jan 2018 16:09:30 +0100
Subject: [cip-dev] Submitting two patches to
	https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/
Message-ID: <CABpTzB1oN+_KY-TGLwtvTnbtO0jHJ5E7GLrcEr4skNdKTOgWUA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Folks,

I decided to submit two patches, as my genesis to this group (warming
up period). Please, review the patches, and tell me (if any?) your
opinion. My aim is customize the repo to be as much generic as
possible (there are other aims, not important for the momentum being).

Thank you,
Zoran Stojsavljevic
_______

[1] https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/52

Improving importbox.sh script

This is since I think (I hope) i have improved the initial
importbox.sh. This one is more descriptive, and has few more options.
Also, the attempt was made to create a more generic bash script which
uses Vagrant.generic file (the actual name of known vagrant
repositories names is changed to generic newBox).

Please, do note that the step [6]: "Executing the command: vagrant up
--provider which provider?" could be improved, but still one can have
argument that there are so far 4 providers, and more than 1 can be
present at the time of testing. The improvements will be to scan
through "vagrant box list command and find out if only one provider is
present, or more?

Please, also note that the first line uses bash.
_______

[2] https://gitlab.com/zoran.stojsavljevic/board-at-desk-single-dev/commit/0307e18883c69a882d3927be657cef6e615863fa
