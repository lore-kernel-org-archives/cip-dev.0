From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 21 Jul 2017 14:55:11 +0100
Subject: [cip-dev] [PATCH 0/3] Add iWave RZ/G1M documentation
In-Reply-To: <1500540535-18905-1-git-send-email-chris.paterson2@renesas.com>
References: <1500540535-18905-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1500645311.12197.127.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2017-07-20 at 09:48 +0100, Chris Paterson wrote:
> This series adds iWave to the vendor list, and documents the iWave RZ/G1M
> board.
> 
> Patches based on linux-4.4.y-cip 7bac4ad.

Applied and pushed, thanks.

Ben.

> Biju Das (3):
>   of: Add vendor prefix for iWave Systems Technologies Pvt. Ltd
>   ARM: shmobile: document iW-RainboW-G20M-Qseven-RZG1M system on module
>   ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M board
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt    | 4 ++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  2 files changed, 5 insertions(+)
> 

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
