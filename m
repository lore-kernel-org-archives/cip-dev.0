From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 15 Mar 2017 17:18:37 +0100
Subject: [cip-dev] Kernel feature support
In-Reply-To: <1489070021.2949.73.camel@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
Message-ID: <58C9695D.9090908@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 09/03/17 15:33, Ben Hutchings wrote:
> We've previously agreed that not all kernel features (drivers,
> filesystems, network protocols, etc.) can be supported in an SLTS
> branch.  I'd like to start working out what the supported features
> should be for the 4.4 branch.
>
> Are members able to share their kernel .config files, showing which
> features are enabled?  Or would you prefer to specify your needs at a
> slightly higher level?

Answering this question is important to discard features in 4.4 that are 
not of CIP interest so we can severely reduce the amount of effort that 
we will need to do in terms of fixes analysis, security etc. in the future.

Please take some time to provide feedback.

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
