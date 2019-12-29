From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 29 Dec 2019 18:25:57 +0100
Subject: [cip-dev] Getting older -cip-rebase versions
Message-ID: <20191229172557.GA18039@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

To prepare -cip-rt-rebase, I'd like to start with -cip-rebase. That
seems to be easy with latest version, but not with the older ones:

pavel at duo:~/cip/k$ git show v4.19.91-cip17-rebase
tag v4.19.91-cip17-rebase
commit 0c809da57d1f66315f0d75cab818cf1121ba652c (tag: v4.19.91-cip17-rebase, origin/linux-4.19.y-cip-rebase)
Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date:   Sat Dec 28 05:55:06 2019 +0900

    CIP: Bump version suffix to -cip17 after merge from stable

pavel at duo:~/cip/k$ git show v4.19.88-cip16-rebase
fatal: ambiguous argument 'v4.19.88-cip16-rebase': unknown revision or path not in the working tree.

Is there way to get to that version? Would it be possible to keep
those tags in future?

Thanks,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191229/eabe499a/attachment.sig>
