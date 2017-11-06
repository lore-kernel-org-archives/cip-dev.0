From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 6 Nov 2017 10:22:25 +0100
Subject: [cip-dev] CIP kernel maintenance and testing report. Weeks 43
 and 44
In-Reply-To: <015d01d356c6$8eff3680$acfda380$@toshiba.co.jp>
References: <59FC8EC0.8090007@codethink.co.uk>
	<015d01d356c6$8eff3680$acfda380$@toshiba.co.jp>
Message-ID: <5A0029D1.2040006@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 06/11/17 07:14, Daniel Sangorrin wrote:
> Hi Agustin, Tom:
>
>> ** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167
>
>  From the link above: "As it stands b at d is about testing the kernel, b at d should use kernel-ci to provision the
> kernel without the overhead of bitbake/docker..."
>
> I agree that you don't need to rebuild cip-core just to check that the kernel's build or boot does not fail.

I would like to see how we unlink the "building" from the "testing" 
completely. Right now it is not but we should.

>
> "... After that the issue of the minimal image / ramfs can be discussed"
>
> Maybe we should also discuss whether B at D is appropriate for testing cip-core packages as well.

Agree.

>
> Thanks,
> Daniel
>
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
>> Sent: Saturday, November 04, 2017 12:44 AM
>> To: cip-dev at lists.cip-project.org
>> Subject: [cip-dev] CIP kernel maintenance and testing report. Weeks 43 and 44
>>
>> Hi,
>>
>>
>> this report covers the activities done by Codethink that are not related
>> with B at D v1.0 release nor our presence at ELCE. This is why week 42 and
>> most of week 43 are not included.
>>
>> ++ CIP Kernel maintenance
>>
>> * Renesas supported Kernel build for using it at B at D v1.0
>> ** Decided to take the same approach as BBB kernel. #167
>> ** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167
>>
>> * Further review of watchdog core triggered keepalive infrastructure
>> backports.
>>
>> ++ CIP Testing project
>>
>> * Renesas board support
>> ** Remote power cycle of Renesas board done using IP Power 9258 Remote
>> PDU. Working on remotely power cycling BBB. This is a request from
>> Daniel W. and a suggestion from AGL CIAT folks. #166
>> ** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/166
>> * Renesas supported Kernel build for testing it at B at D v1.0
>> ** Decided to take the same approach as BBB kernel.
>>
>> * Our daily reports sent to cip-tests-results mailing lists are now
>> referred to the latest CIP kernel 4.4.92-cip11
>>
>> * Several bugs and improves in configurations has been added to gitlab
>> out of the demos and suggestion at ELCE 2017. The most relevant are:
>> ** B at D should use its own test-definitions repo and should be local #158
>> *** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/158
>> ** kernelci webserver should start at VM boot time #160
>> *** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/160
>> ** Builds older than 5 days does not appear on kernelci #164
>> *** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/164
>>
>> * Several small improvements in the documentation as consequence of the
>> ELCE demos like #120
>> ** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/120
>>
>> * Some support actions taken after ELCE 2017.
>>
>> ++ Other activities
>>
>> * Preparation of an online training session.
>>
>> * Trying out CIP Core to evaluate future challenges for testing it with B at D
>> ** Discussion about the challenges that dependencies bring for testing
>> the kernel and/or  system when the underlying OS is not Debian, the CIP
>> default distro.
>>
>> * Planning the coming key actions for the CIP Testing project based on
>> the input got at ELCE 2017
>>
>> Tom Pollard is still helping us in different areas, focused in the
>> coming online training session.
>>
>> Best Regards
>> --
>> Agustin Benito Bethencourt
>> Principal Consultant - FOSS at Codethink
>> agustin.benito at codethink.co.uk
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
>
>


-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
