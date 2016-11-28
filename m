From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 28 Nov 2016 14:47:17 +0100
Subject: [cip-dev] Features backports
In-Reply-To: <582EF368.4090006@codethink.co.uk>
References: <582EF368.4090006@codethink.co.uk>
Message-ID: <2a7cf15f-4b7b-b23d-5385-e72e16fe465a@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2016-11-18 13:26, Agustin Benito Bethencourt wrote:
> Hi,
> 
> as you probably know, the more features we backport, the higher will be
> the maintenance cost overtime so as a strategy, we need to be very
> conservative.
> 
> I sent a mail some days ago about the features backported already by
> Linaro for their LSK (Linaro Stable Kernel) for your evaluation. I bring
> today some potential backports related with security features and
> hardware support that has been identified by Ben H.
> 
> * UBSAN support:
> <https://git.kernel.org/linus/c6d308534aef6c99904bf5862066360ae067abc4>
> 
> * Increased user-space ASLR range for ARM:
> <https://lwn.net/Articles/667790/>
> 
> * Page poisoning on free:
> <https://git.kernel.org/linus/8823b1dbc05fab1a8bec275eeae4709257c2661d>,
> <https://git.kernel.org/linus/1414c7f4f7d72d138fff35f00151d15749b5beda>
> 
> * SLAB/SLUB freelist randomisation
> 
> * Hardened usercopy
> 
> * Do Members use SLUB? if not, we should take a look at KASAN support
> for SLAB
> 
> * drm/tilcdc update? (many bug fixes post-4.4)
> 
> * AM33xx RTC support:
> 
> <https://git.kernel.org/linus/461932dfb54ebaf7da438fd8b769a01ce97a9360>,
> <https://git.kernel.org/linus/b5a553c08bec14a058501df3fa6eb39f63f00a98>
> 

To add two features areas from our requirement list:

- Distributed Switch Architecture, basically the level of 4.8 would be
  sufficient. However, there might be too many dependencies on
  networking core changes. If we pick 4.9 as next SLTS, then this
  becomes obsolete.

- Graphic support for AM57xx from more recent kernels, but things may
  even still depend on TI's vendor kernel (in which case it would be
  too early).

Both are a bit vague yet, but I'm trying to clarify more details.
Comments are already welcome, of course.

Jan
