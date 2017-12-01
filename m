From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 01 Dec 2017 15:57:45 +0000
Subject: [cip-dev] [PATCH] builddeb: introduce variables for
 control-file customization
In-Reply-To: <20171127173037.019c138b@md1em3qc>
References: <20171127161345.17880-1-henning.schild@siemens.com>
	<20171127173037.019c138b@md1em3qc>
Message-ID: <1512143865.18523.126.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2017-11-27 at 17:30 +0100, Henning Schild wrote:
> Ben,
> 
> could you please have a look at that patch. I actually need that or
> something similar to build a cip-kernel for an embedded target. But i
> thought i start off with an upstream patch and ask for a backport
> later.

I don't believe these dependencies are correct for a kernel built with
'make deb-pkg'.

I'll go and put my Debian hat on to write a longer reply.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
