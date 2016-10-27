From: hidehiro.kawai.ez@hitachi.com (Hidehiro Kawai)
Date: Thu, 27 Oct 2016 15:23:51 +0900
Subject: [cip-dev] Maintenance policies and early considerations II
In-Reply-To: <57E3A79F.1020602@codethink.co.uk>
References: <57E3A79F.1020602@codethink.co.uk>
Message-ID: <58119D77.4070806@hitachi.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

(2016/09/22 18:42), Agustin Benito Bethencourt wrote:
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

Basically, releasing the kernel as source is sufficient.  But if we
release it as binary only for the specific reference board, users may be happy.

> +++ Kernel features
> 
> The project needs to decide which architectures, drivers and other 
> kernel features are to be supported by the core team and its releases. 
> This could be documented purely as human-readable text or in a 
> machine-readable form so that the kernel build process can warn when 
> building an unsupported configuration.  It may also be sensible to 
> specify the supported toolchain versions.

To reduce the maintenance effort, we should limit drivers and features
to be supported (`support' in this context means tracking security/critical
bug fixes, backporting requested patches, and so on).

One idea is to express the supported features in the form of kernel
config.  It is machine-readable, and it's not so difficult to covert
it to human-readable.  But I'm not sure if it actually work well because
there are non-configurable features.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
