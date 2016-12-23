From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 23 Dec 2016 16:46:45 +0000
Subject: [cip-dev] [PATCH 4.4-cip 0/6] Extend user-space ASLR range
In-Reply-To: <7c58c7d6-92fa-4b99-aa15-25c41243810c@siemens.com>
References: <1481241380.1860.120.camel@codethink.co.uk>
	<7c58c7d6-92fa-4b99-aa15-25c41243810c@siemens.com>
Message-ID: <1482511605.1860.200.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

[Sorry for the delay; I haven't been feeling well.]

On Fri, 2016-12-09 at 13:20 +0100, Jan Kiszka wrote:
> Did you try to discuss the back-port topic with the KSPP folks or other
> key persons involved in these patches? In the ideal case, the authors
> can be CC'ed, do not get annoyed by "these crazy people doing legacy
> stuff", and may even do some reviews.

I would normally cc the upstream developers, but I was hesitant to do so
for CIP because this is not related to an official stable branch.
Perhaps I should ask on the KSPP list whether a cc for such feature
backports would be appreciated?

On Mon, 2016-12-19 at 11:52 +0100, Jan Kiszka wrote:
> I've chatted with Elena over this last week, and she talked to Kees
> who
> pointed out that the Android people are also doing KSPP backports to
> 4.4
> (thanks, folks!). I didn't check any details, just a heads-up to avoid
> duplicate work.

Thanks for letting me know.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
