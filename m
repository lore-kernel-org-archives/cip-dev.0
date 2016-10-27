From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 27 Oct 2016 07:13:54 +0200
Subject: [cip-dev] Maintenance policies and early considerations II
In-Reply-To: <57E3A79F.1020602@codethink.co.uk>
References: <57E3A79F.1020602@codethink.co.uk>
Message-ID: <66bad2dc-6535-a87e-de97-833d1c695a46@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2016-09-22 11:42, Agustin Benito Bethencourt wrote:
> Hi,
> 
> a second consideration discussed during the meeting. Feel free to
> provide your opinions or considerations about them.
> 
> ++ How should the kernel be released?
> 
> +++ Binaries or sources
> 
> While commercial distributions like RHEL/SLE include a small number of
> supported kernel configurations in binary form, the CIP kernel should be
> primarily released as source, with the configuration controlled by its
> users.

Ack.

> 
> +++ Kernel features
> 
> The project needs to decide which architectures, drivers and other
> kernel features are to be supported by the core team and its releases.
> This could be documented purely as human-readable text or in a
> machine-readable form so that the kernel build process can warn when
> building an unsupported configuration.  It may also be sensible to
> specify the supported toolchain versions.

Not sure how to read these threads as I didn't manage to follow their
evolution: This aspect of support constraints is still in scope? I think
it will be important in order to keep backporting and testing efforts
realistic. The enterprise distros are doing the same.

Regards,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
