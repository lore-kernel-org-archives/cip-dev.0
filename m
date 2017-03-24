From: wolfgang.mauerer@siemens.com (Wolfgang Mauerer)
Date: Fri, 24 Mar 2017 17:15:45 +0100
Subject: [cip-dev] u-boot policy for CIP
In-Reply-To: <HK2PR0601MB13296740334D8058F10B1919B7260@HK2PR0601MB1329.apcprd06.prod.outlook.com>
References: <HK2PR0601MB13296740334D8058F10B1919B7260@HK2PR0601MB1329.apcprd06.prod.outlook.com>
Message-ID: <650f88f6-d967-19dd-3e9f-ca077c7d8310@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

On 16.03.2017 13:07, Chris Paterson wrote:
> Hello all,
>
>
>
> I?m bringing a discussion I?ve started in other places here as it will
> benefit from wider participation.
>
>
>
> As you know the aim of CIP is to maintain not just the Kernel, but a
> number of other ?core packages?. One of these is u-boot.
>
>
>
> For the Kernel the project will provide super long term support for a
> chosen version. For u-boot this will be harder to achieve as
>
> a)      there are no ?LTS? versions of u-boot to base our ?SLTS? version on;
>
> b)      a lot of hardware providers tend to use forks for their
> platforms, rather than add full functionality upstream.

thanks for raising this question. The problem you describe does not just
exist for U-Boot, but also for many other components that we will be
looking into.
>
>
>
> Ideally CIP should choose a version of u-boot and use it when
> testing/verifying the CIP Kernel on the reference hardware. How we
> actively maintain that version (bug fixes/security patches/features?) is
> another question. Given that most devices in the field won?t have a way
> to update u-boot in the field (security issues/practicalities), I think
> ?SLTS? support for u-boot may not be required. Perhaps we just tag a
> version of u-boot at the launch of a new CIP Kernel and stick with it?

I also assume that updating the bootloader is currently not required
for many appliances, so it suffices to ensure it is labelled properly
and can be (slt) re-produced for these cases.

However, things change when networking features of U-Boot come
into play. These are usually used during product development, but
I imagine that certain (IoT-class) devices will use such features more
in the future. For these cases, it would be desirable to have something
like a CIP standardised update process for the boot loader besides
a SLTS version. Do member companies plan to employ these features
for other than development/debugging purposes in the future?

If the boot loader is part of a secure/trusted boot scenario, the
ability to update U-Boot will also become more important, but that
depends on the threat models.

To me, it seems important to collect information from the members
on U-Boot use-cases, and then decide if and what further action is
necessary. For Siemens at least, I would not be able to come up with a
definitive set of requirements without asking around in the company.

>
>
>
> How do we decide what u-boot version to support? Currently it looks like
> the BBB platform are shipped with 2014.04 and the Renesas platform is
> shipped with 2013.01. That said, it looks like there is upstream support
> for BBB [1], but how the feature set compares to the version shipped
> with the platform I don?t know. There is also support for some Renesas
> platforms [2], but not for the exact board CIP will be using.
>
>
>
> Do we want to push Ti/Renesas to ensure there is full support for their
> boards upstream? When this is done do we pick the first version that
> includes this support to work with? Or do we just stick with the vendor
> provided forks?

Having upstream support for the HW components is a critical precondition
for me. CIP has committed to working with the upstream projects as
closely as possible, and maintaining code outside is usually a good
recipe for disaster... Unless there's a really compelling reason
for sticking with a vendor fork, which I cannot think of any in our
context, we should always start from the upstream projects.
Or, in other words: Companies should usually be pushed to bring their
changes upstream, I'm not aware of any case where this has created more
problems than it has solved issues.
>
>
>
> Is there a particular feature set that CIP requires?

that is something we would have to define. I again guess it makes sense
to collect configurations from products of the member companies, as the
in-company variability will already likely be substantial.

Best regards, Wolfgang

>
>
>
> Forgive my random ramblings, I appreciate there are a lot of different
> questions here!
>
>
>
>
>
> [1] https://github.com/u-boot/u-boot/tree/master/board/ti/am335x
>
> [2] https://github.com/u-boot/u-boot/tree/master/board/renesas
>
>
>
> Kind regards, Chris
>
>
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
