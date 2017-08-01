From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 01 Aug 2017 16:34:20 +0100
Subject: [cip-dev] Kernel maintenance and CIP testing report weeks 28,
	29 and 30
In-Reply-To: <598099F1.7010908@codethink.co.uk> (Agustin Benito Bethencourt's
	message of "Tue, 1 Aug 2017 16:10:41 +0100")
References: <598099F1.7010908@codethink.co.uk>
Message-ID: <87wp6ncner.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, some comments on the individual issues below.

Agustin Benito Bethencourt <agustin.benito@codethink.co.uk> writes:

> Dear CIP friends,
>
> this is the report of the major actions related with those activities
> led by Codethink Ltd. Some of the reported topics were already
> communicated through this mailing list.
>
> ++ Kernel maintenance
>
> 1. Backported of the basic support for the Renesas board (family) has
> been merged.
>
> 2. The first round of kernel features review has been provided. Some
> feedback is still pending. Ben H. participated in the CIP TSC
> bi-weekly call.
>
> 3. Now we need to define the next steps in the kernel maintenance front.
>
> 4. As usual, Ben H. is contributing to the upstream 4.4 LTS cycle.
>
> ++ CIP Testing
>
> 1. E-mail configuration in LAVA is done. Robert Marshall is publishing
> the outcome of the basic health checks in the cip-testing-results
> mailing list. Feel free to join:
> https://lists.cip-project.org/mailman/listinfo/cip-testing-results The
> documentation for CIP members to send reports through mail is work in
> progress. https://gitlab.com/cip-project/cip-testing/testing/issues/102

Some documentation has been added to the wiki detailing how to set this up
I'll be adding more information there.

>
> 2. B at D now works on a W10 machine with little additional
> configurations. Both, Windows and Linux users share the same
> installations and configuration steps except when specifically
> mentioned. Waiting to receive feedback from
> Members. https://gitlab.com/cip-project/cip-testing/testing/issues/106
>
> 3. A change in git://git.linaro.org/qa/test-definitions.git had a
> major impact in B at D. It has been fixed
> now. https://gitlab.com/cip-project/cip-testing/testing/issues/116
>
> 4. There is progress in using B at D behind a web
> proxy. https://gitlab.com/cip-project/cip-testing/testing/issues/99
>
> 5. Robert has started the trials to update the LAVA version shipped
> with B at D. It includes several fixed to issues we are facing plus
> several improvements we will need in the near
> future. https://gitlab.com/cip-project/cip-testing/testing/issues/114

I have a provisioned box with the latest version of lava - however there
are problems with authentication that I'm currently investigating.

Once that is working I expect to look at how to attach health check
results to LAVA notifications
https://gitlab.com/cip-project/cip-testing/testing/issues/118

and then consider the issues involved in allowing users who are not the
original tester to import those results into their own B at D instance.

We will also need to investigate how tests and be signed and how LAVA
will verify those signatures.


Robert

>
> 6. Other topics
>
> * Some weeks ago we reported to the LAVA team an issue that has
> already been fixed upstream. Another good reason for updating
> LAVA. https://gitlab.com/cip-project/cip-testing/testing/issues/84
>
> * Several issues has been fixed like tickets #112, #92
>
> * As reported, new repositories has been created and
> populated. https://gitlab.com/cip-project/cip-testing/testing/issues/100
> ** We are starting to populate CIP-kernel-test-logs repository as a
> first step towards publishing the "passed test" logs in a public repo
> in order to compare the logs from tests done by other  Members.
>
> * There is no room for celebrating the CIP workshop at ELCE during the
> even. We will need to include it the previous day, right after the CIP
> TSC f2f meeting.
>
> * At least Agustin B.B. and Ben H. will attend to ELCE.
>
