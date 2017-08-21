From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Mon, 21 Aug 2017 11:29:39 +0100
Subject: [cip-dev] Kernel maintenance and CIP testing report weeks 31,
	32 and 33
In-Reply-To: <599AB325.9060902@codethink.co.uk> (Agustin Benito Bethencourt's
	message of "Mon, 21 Aug 2017 11:17:09 +0100")
References: <599AB325.9060902@codethink.co.uk>
Message-ID: <87fucltdrg.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt <agustin.benito@codethink.co.uk> writes:

<snip>
> ++CIP testing project
>
> * Focused on LAVA update in order to fix several
> issues. https://gitlab.com/cip-project/cip-testing/testing/issues/114
> ** QEMU health check
> works. https://gitlab.com/cip-project/cip-testing/testing/issues/121
> Focus now is making the health check works on BBB with updated LAVA.
> ** Discussions with upstream on some of the issues found.
> ** Summary about the work done sent to cip-dev mailing list.
> * Progress on having B at D working behind a web-proxy
> https://gitlab.com/cip-project/cip-testing/testing/issues/99
> * Daily health checks sent to the cip-testing-results mailing list
> * Build artifacts referenced in the Beaglebone black health check are
> no longer accessible. Issue closed

#129 is also associated with this but for the moment leaving it open hoping for feedback from the reporter

> * Issue in kernelci with csrf token is under investigation
> https://gitlab.com/cip-project/cip-testing/testing/issues/128
>

This just needs the tested changes integrated into the provisioning script


> As usual, for a fine grain tracking of this project you can check the
> CIP testing project progress board:
> https://gitlab.com/cip-project/cip-testing/testing/boards
>
> ++Other tasks
>
> * Data flow diagram for B at D (level 0) sent to cip-dev ML
> * B at D planning and progress added to the wiki:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingmanagement
> * ELCE workshop
> ** ELCE 2017 workshop page created:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipconferences/cipwselce2017
> ** B at D 101 training session proposal sent. To be confirmed by
> TSC/Board
> https://gitlab.com/cip-project/cip-testing/testing/issues/126
>
> Best Regards
