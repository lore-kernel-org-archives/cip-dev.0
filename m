From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 21 Mar 2019 09:15:41 +0000
Subject: [cip-dev] CVE tracker: questions
In-Reply-To: <2544745.Y8d6tg5VCe@linux-3zh6>
References: <2544745.Y8d6tg5VCe@linux-3zh6>
Message-ID: <1553159741.3557.1.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-03-20 at 16:01 +0100, Agustin Benito Bethencourt wrote:
> Hi Ben,
> 
> during the past face to face TSC meeting that took place in N?rnberg, there?
> were two questions about the CVE tracker you have done that would need some?
> more details from you that what I provided back then.
> 
> Is the CVE tracker in a state that can be used by CIP Members?

I think so, yes.

> If it is, under which conditions? Does it work for any kernel or needs to be?
> tuned?

It currently only works for mainline and stable branches.  I have an
open issue to add support for CIP branches.

> Can we advertise the CVE tracker in the coming events in Japan in July?

That would be fine with me.

> I would like to add the following questions
> 
> Is this a work you plan to maintain in the coming future?

So long as I'm working for CIP, yes.

> Would it be valuable to somehow keep the outcome of the tracker in Gitlab so?
> we can keep track of the patches that require attention, so the Kernel?
> Maintenance team can also get involved?
> 
> Would it work for -rt ?

Not currently, no.  If and when I add support for CIP branches, I
expect -rt branches to be supportable in the same way.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
