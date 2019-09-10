From: chris@reproducible-builds.org (Chris Lamb)
Date: Tue, 10 Sep 2019 14:04:53 +0100
Subject: [cip-dev] Reproducible Builds in August 2019
In-Reply-To: <20190910125115.GA16598@amd>
References: <5b563474-b5ff-4de2-b370-6a25752c6c26@www.fastmail.com>
	<20190910125115.GA16598@amd>
Message-ID: <d91a8013-7187-467c-a458-624b447ba3b5@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> # At some time in April 2018, the Webmin development build server was
> # exploited and a vulnerability added to the password_change.cgi
> # script. Because the timestamp on the file was set back, it did not
> # show up in any Git diffs. This was included in the Webmin 1.890
> # release.
> 
> That sounds to me like source code was modified locally on the build
> server, not any sort of advanced toolchain compromise.

Whilst I would concede it was not a technically advanced attack it is
still an example of a lengthy and on-going compromise of the build
process and, more importantly, something that Reproducible Builds
would/should have been able to detect... hence its inclusion in our news
updates. :)


Best wishes,

-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o
