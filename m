From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 12 Apr 2017 16:25:41 +0200
Subject: [cip-dev] Kernel feature support
In-Reply-To: <1489070021.2949.73.camel@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
Message-ID: <590f9bee-c4af-ca12-c2ff-93f934d5df85@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-03-09 15:33, Ben Hutchings wrote:
> We've previously agreed that not all kernel features (drivers,
> filesystems, network protocols, etc.) can be supported in an SLTS
> branch.  I'd like to start working out what the supported features
> should be for the 4.4 branch.
> 
> Are members able to share their kernel .config files, showing which
> features are enabled?  Or would you prefer to specify your needs at a
> slightly higher level?

Some more configs from our side. Some are just stripped-down defconfigs,
some are 4.1-based (to become 4.4 eventually), but I hope they are
useful. Any out-of-tree switch is to be ignored, of course.

I hope there will be more configs in the future. E.g., some projects on
4.4 are still running an expanded development feature set.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
-------------- next part --------------
A non-text attachment was scrubbed...
Name: configs.tar.xz
Type: application/x-xz
Size: 48900 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170412/06b0ec9b/attachment-0001.xz>
