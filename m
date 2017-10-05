From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Thu, 05 Oct 2017 09:51:59 +0100
Subject: [cip-dev] CIP testing and kernel maintenance report week 38 and
	39
In-Reply-To: <59D223C3.4030104@codethink.co.uk> (Agustin Benito Bethencourt's
	message of "Mon, 2 Oct 2017 13:32:19 +0200")
References: <59D223C3.4030104@codethink.co.uk>
Message-ID: <87a8167z9s.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi

Agustin Benito Bethencourt <agustin.benito@codethink.co.uk> writes:

> Hi,
>
> this is a a summary of the main tasks performed by the Codethink guys
> during the last couple of weeks. Due to vacations and sickness, we
> have been less active than usual.
>
> + Week 38 and 39 2017
>
> ++ Kernel Maintenance
>
> No significant progress.
>
> ++ CIP testing project
>
> * A script to populate initramfs created and merged. Now initramfs is
> built locally again with the new LAVA. Ben H. helped to solve this
> issue.
> ** #111 https://gitlab.com/cip-project/cip-testing/testing/issues/111
> ** #136 https://gitlab.com/cip-project/cip-testing/testing/issues/136
>
> * LAVA updated. The new release will come with 2017.7 version.
> ** tmp data now is cleared with the new LAVA version
> *** #84 https://gitlab.com/cip-project/cip-testing/testing/issues/84
> ** Verbosity comes with the new LAVA version
> *** #115 https://gitlab.com/cip-project/cip-testing/testing/issues/115
>
We should also report that #139 https://gitlab.com/cip-project/cip-testing/testing/issues/139
is preventing the provisioning of a fresh B at D instance

I've created a branch
https://gitlab.com/rajm/board-at-desk-single-dev/tree/fix-new-kernelci
which enables provisioning but still requires some manual intervention
to get a fully working box


Robert

> +++ Other minor accomplishments
>
> * Added to known issues the health check 30 seconds waste
> ** #56 https://gitlab.com/cip-project/cip-testing/testing/issues/56
>
> * Support request solved. #129
> ** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/129
>
> * Identified a link on the LAVA page that needs to be changed
> ** #133 https://gitlab.com/cip-project/cip-testing/testing/issues/133
>
> ++ Other tasks
>
> * CIP workshop at ELCE
> ** Call for participation for the B at D 101 training session published.
> ** Material and set up required for the training session confirmed and
> discussed with the Linux Foundation.
>
> * Y2038 meeting at ELCE confirmed.
> ** Call for topics among CIP members sent.
> ** Some CIP Members has confirmed their presence. More to come.
>
> Best Regards
