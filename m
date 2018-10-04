From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Thu, 04 Oct 2018 12:43:10 +0100
Subject: [cip-dev] Kernel configurations in the CIP project
In-Reply-To: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de> (Lukas
	Bulwahn's message of "Tue, 2 Oct 2018 18:53:16 +0000")
References: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de>
Message-ID: <877eiyos35.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Lukas

Thanks for your email, comments below.

Lukas Bulwahn <Lukas.Bulwahn@bmw-carit.de> writes:

> Hi Robert,
>
> If I recall our conversation and follow the discussion on cip-dev
> correctly, you are still maintaining the test builds and
> infrastructure from the CIP project, right?
>

That's correct

> Could you provide to Markus Kreidl, Nicholas McGuire (see CC) and me
> the kernel configurations you use in the test builds for the different
> CIP members?
>

I'm using the kernel versions with the latest CIP tag, I use exactly
the procedure described on this page

https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipsystembuildhowto#building-the-cip-kernel-with-kernel-ci

building for the beaglebone black and the Renesas iwg20m board.


Robert

> Background:
>
> Markus Kreidl has written a tool that determines which patches, which
> hunks of those patches are relevant to a given configuration. We would
> be interested in providing an overview of which patches are especially
> relevant for the given configs of a new CIP kernel patchlevel release,
> and hence, the CIP maintainers (hopefully, it is not just Ben) are
> informed about those and can have a good look at those specific
> patches when they provide a new kernel release version.
>
> If it useful, we would follow-up how to make that fit nicely into the
> existing review and reporting process. If it not useful, we learned a
> lesson about our tool.
>
> Best regards,
>
> Lukas
> ?
>

-- 
Robert Marshall, Software Developer                       Codethink Ltd
Telephone: +44 7762 840 414       3rd Floor, Dale House, 35 Dale Street
https://www.codethink.co.uk/         MANCHESTER, M1 2HF. United Kingdom
