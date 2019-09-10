From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Sep 2019 14:51:15 +0200
Subject: [cip-dev] Reproducible Builds in August 2019
In-Reply-To: <5b563474-b5ff-4de2-b370-6a25752c6c26@www.fastmail.com>
References: <5b563474-b5ff-4de2-b370-6a25752c6c26@www.fastmail.com>
Message-ID: <20190910125115.GA16598@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Media coverage & events
> =======================
> 
> A backdoor was found in Webmin [2] a popular web-based application used
> by sysadmins to remotely manage Unix-based systems. Whilst more details
> can be found on upstream's dedicated exploit page [3], it appears that
> the build toolchain was compromised. Especially of note is that the
> exploit "did not show up in any Git diffs" and thus would not have
> been

Page says:

# At some time in April 2018, the Webmin development build server was
# exploited and a vulnerability added to the password_change.cgi
# script. Because the timestamp on the file was set back, it did not
# show up in any Git diffs. This was included in the Webmin 1.890
# release.

That sounds to me like source code was modified locally on the build
server, not any sort of advanced toolchain compromise.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190910/1f02de85/attachment.sig>
