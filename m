From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 23 Jan 2017 14:14:32 +0100
Subject: [cip-dev] Update on Patch and mirroring KernelCI code
In-Reply-To: <CANm2L4nyRJ2rSE6QqWZBQ2_HqhRB7vA41ois4i85Ls6Y73WG+A@mail.gmail.com>
References: <CANm2L4nyRJ2rSE6QqWZBQ2_HqhRB7vA41ois4i85Ls6Y73WG+A@mail.gmail.com>
Message-ID: <6ea9e1f8-8853-d65c-2bdd-bf936742799f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Don,

On 01/23/2017 01:39 PM, Don Brown wrote:
> I like the change to the patch and I'll incorporate it tonight.

Great.

> We are already mirroring the KernelCI Backend and Frontend and I had
> almost the exact same thought this weekend that we already need to
> modify the code to get ours working. I don't mind doing this in the
> short term. However, this can be a slippery slope since we could easily
> get to the point where we've essentially forked their code.

I agree. There needs to be some strict rules for applying patches.

> I would prefer to work with the KernelCI upstream to incorporate our
> modifications into their code for the long-term.

Okay, understood. What about introducing a default configuration that
clones for upstream but it could be overwritten as config option?

Thanks,
Daniel
