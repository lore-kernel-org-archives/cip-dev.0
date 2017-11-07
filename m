From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 7 Nov 2017 16:28:40 +0100
Subject: [cip-dev] [PATCH 0/2] Remove firmware files from CIP kernel
In-Reply-To: <1510067797.2465.22.camel@codethink.co.uk>
References: <cover.1509978788.git.jan.kiszka@siemens.com>
	<1510067797.2465.22.camel@codethink.co.uk>
Message-ID: <a2cbc127-b929-32ba-dfe9-9497166097f3@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-11-07 16:16, Ben Hutchings wrote:
> On Mon, 2017-11-06 at 15:33 +0100, Jan Kiszka wrote:
>> This backports the removal of in-kernel firmware files that upstream
>> did for 4.14.
>>
>> Besides the issue mentioned in the upstream commit, the primary
>> motivation for us are undefined licenses (according to WHENCE) for a?
>> couple of the files. This creates entries in automated license
>> analysis
>> and, depending on the conclusion drawn from them, can mean further
>> activities like kernel source package surgeries. For similar reasons,
>> Debian removed those files long ago as well.
> 
> Right, this seems like a reasonable change.
> 
> I couldn't apply your patch 1, apparently because some of the deleted
> ihex files have lines longer than the SMTP line limit, but I believe
> I've ended up with an equivalent commit.

Yeah, I was afraid of that to happen (and had to use --no-validate to
get the patch out). Good that such a file is gone now.

I'll cross-check, but the conflict I had to resolve was only in the
top-level Makefile, and that was trivial.

Thanks,
Jan
