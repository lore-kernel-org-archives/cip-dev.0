Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119AC48260
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 04:32:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.34620.1708317141226041317
 for <cip-dev@lists.cip-project.org>;
 Sun, 18 Feb 2024 20:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41J4WIr6937794; Mon, 19 Feb 2024 13:32:19 +0900
X-Iguazu-Qid: 2rWgQ8FBUvsRix0PNV
X-Iguazu-QSIG: v=2; s=0; t=1708317138; q=2rWgQ8FBUvsRix0PNV; m=37RFd0NvV0dRBBK4py0lCPxBwP5KHk4QM7U1kj9Zh+I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 41J4WHKo1372791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Feb 2024 13:32:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL3NtJA/1IYDZ3S6PvCJbbmPd/I/OS8lJ1unZPeQavcBHtVdbCQdAvWS/Uy1cuPzS5W/Z8ydRaYAhDofRKzuqpHRvEddfZx+9NU/P/M/n45IwiIAekPPADeeSXiHIG+tOrKd2OADtOoTAbPOCXkk3FLfO0CHHqw06a72rywoWJcnzuoqz59VFA/gUKmvTEsWUBY2TPuvGz8m93bWqhtb91XWVrsAAXib9+CZDywzBRDxnQAjGCXHNSLzvRFXRTB1c8AryJYLJMe3kb8kIOJU0MlDDxkVkQmIpEuvgwIN+sWlG/5whB6t25OVsp1dWJmP6MtUu6YD1FJ7mcXo1/H0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GFlgV/YbftlXUXrLU80Y22ti1NFjKcmww7KbGT+JUE=;
 b=R0voSxzm3ZfjvvnqsWwqfhVhW1HgDO2TTGbqVHxnSHfZdLjLduKkWKugGeYgtaH7AsohKaqR//aX6YsEyBII3Q5WjyhvpT6Djll1yAOeUthT/zy0eZsV49V7gL4X0aVu6fb01i+gcPONEKe6/A8Y0hq6LQBUXeWboynjYKNPaDd7shbzBDuH+UzXhW8cUZaZdAdHZAjOSB9UbdmbgiPQXINO57WZERz/m0KXjjlgNFLVrx5XBBmHcJsAJUc33ZhjWnlNA6188sYeNeu/gFxLb6qXygYWYAqY70/A4EavgnHt3GFh91lzGARFWTM1/fd3EoqXSF0tyidPHTSyovUMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoAAT66ioAD7Ws/g
Date: Mon, 19 Feb 2024 04:32:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61034E05C271281A1CD2FE78C2512@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB10098:EE_
x-ms-office365-filtering-correlation-id: 808a5d54-a9b8-4113-3239-08dc3103bfa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RmZICci3FPSX/DGukPcKlB3p9ma/Q326cE6bOm8KEM3XdPPKsRrHi1e36LZRtjud7gXnMt8EAPYjfn79SmAPVqU6VTTjs6LYfUBL4ES0MfMLq1Nvi6OE9mf4v636vzu6OAeLQvOPsJ6HacjlKkCs6Xx/CLamyvPMlpc1lzFexozDTQcpS+3IMHLKI0xY5suZCKFbrvU1eIvw+vnL09rx+5+Gw4wwAKIlDbpmyploWX6yxDA7M5yjgsyYIVunWeVMlMBgdaH/CudGZdkUdz7gkBTvbUHw6dUYJZw4BGJTERYjdOmNLVUukbeOpA+8ls0iB/gMqHNLHoD6mv6d8rV8qZ80uC70Ic8tgfFNf1Ac8ClcXxtU8Skn718RIzb2HM97BQSDaOPg6cnPZukMXFjCdo7K9rLT+o6kS/FLuJfdbnTxX6DXEZpwhF2HYs8LC5RjBeoJBAJFVd5R4MsLBnffFbxAmu3ZhZdhr2EsF5yVTSdWOwDT2uqoveXjQJ5P1kZvYKHeSMPqsKg93/O/wVGxyxGW0W/yzEShdCxr9o2k3+23M/1RfG1mpCz42rehKUuOeJH4Gg7biay8zBnp1GWNWm1QiJsMJzvEZP765OMRp3I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(166002)(86362001)(33656002)(85182001)(122000001)(38100700002)(53546011)(966005)(6506007)(7696005)(9686003)(316002)(478600001)(54906003)(71200400001)(83380400001)(41300700001)(26005)(107886003)(38070700009)(66899024)(2906002)(4326008)(6916009)(5660300002)(55016003)(66476007)(66446008)(64756008)(66946007)(52536014)(15650500001)(66556008)(9326002)(76116006)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Uk9FME1NU3dNRHp0YlV3b2w0RVNHU3VJUXNSM0pROHYrWUMvQnF1NWJp?=
 =?iso-2022-jp?B?R2cvdE4vbldrRkxCTXN4SGNMVWtSSVdKSFgwMjNoTk10SzczcjMyTmtF?=
 =?iso-2022-jp?B?VXpndnY5aW15eWdVcjllVTFIdWZaODg2ZDMwUngydEZReDVLKzRPY2tj?=
 =?iso-2022-jp?B?SXFFbFhwSmlNWVF0YVJnZEZZNGdZS01DaGo0QWw2QXZJTVdpRys1blFE?=
 =?iso-2022-jp?B?cFB6cW5qVjZXY1RnQWhrODZEbTl5VkhxMmRXSFBsUk9Ia0t6OUNPQzVo?=
 =?iso-2022-jp?B?ZUNIdmozUmFYaWdiUDl2SE9iQnN1Sll3SGUzUThNZEJJMVRoTlExN2Qy?=
 =?iso-2022-jp?B?a0NveERZQ1kzOURnTnhxZ0U2MktjVHN1a0pjaWtqRFJOa09nZ0YwYk1E?=
 =?iso-2022-jp?B?Z3dnZzd5NHA2bnZrTFRNMEk5WWlydVF0ZXBFYnVGWTc2VUxBNGVocmcv?=
 =?iso-2022-jp?B?MW1iQkNtdWljcXFZMUk1U1k4V3hRTlpYbnRKekhIMHkyRGJROUxKOHFS?=
 =?iso-2022-jp?B?a1dmL29vQUxIQ3ZzTEtXQllUQUY5Y2MvZ0gySDNDcnJvcndoZGl6dk1F?=
 =?iso-2022-jp?B?TnNBSVRxZG9SQ3VYbHVxS0pwU1YrRVdjOC84cHYvRVJFQUpxMzU2aW5L?=
 =?iso-2022-jp?B?SnY2eXVGUC8wMzBGN0VkMk5xeUJCRTlvYlJPYm5FY08wQTdVeElQdnc4?=
 =?iso-2022-jp?B?MmpkYVJjVzNtR1FBdFBZTDI1YTNBbzV6WWpERW9VWWNjTi9HdEVUR1FD?=
 =?iso-2022-jp?B?ZGh1ZUhpdGM4NWZkOS9KN0NFcWZ6U2pOS1E2Ym5DaUltempoM3FlVUVU?=
 =?iso-2022-jp?B?Q1RFN3lYMkwyamFoUENldi9PRm9VMll0ejhiWkJSU1JEenhXVjZ3KzBK?=
 =?iso-2022-jp?B?Wks2bTc1RHFXRTdxR25jRWswYWZzaFBuTnJLbmZRRFRuL2s3bkVmWFRq?=
 =?iso-2022-jp?B?UnVBOVJnS2tsN0RSVFJaekNHbHA5azd3NFFKQ2YvcWl0OGtnZ0lnZUg3?=
 =?iso-2022-jp?B?VXE1QkV6WjRCc1JiaWNyOWZmN2xvbkVNMjFxODQ4alVFcThtck51Q0hR?=
 =?iso-2022-jp?B?VUQ2VFh0cUZhNnV4anRQcnZ6WE5mZ3lSWDFsdG9rR0ZIQ3dSU3MxYVd3?=
 =?iso-2022-jp?B?dytldGxMZ2xlQXZFV2NGa3JCUzNKa2s1djI3UHF5dXpBM3hFRURHMWhR?=
 =?iso-2022-jp?B?enlWRjkrL3FRWkxUcENHa2RSbVhWNmJtYnhvUktZckVYK25xaGFuZ2xT?=
 =?iso-2022-jp?B?MUhYV0FsSTNqZk9kZmp6YlEwM2hGWU5pQzQ2NGFRRmFEWXdrdmlIUXdr?=
 =?iso-2022-jp?B?UDRBWlpVbXpSZ3U3YU00WXhrQkgvRXpocm13RU5pYjNRNWl6OXFKcHE4?=
 =?iso-2022-jp?B?dDdiMmhwMWdyaXJ1VWwrcHcrdVZIWDN4YndWU2xyYVpZbnNMTlNwNG9Z?=
 =?iso-2022-jp?B?RExFVGdUd3lIbG1aTHZYMG02ak5Kc3cxbjlRc0JkMXQ1YnNOZ3JIWWNZ?=
 =?iso-2022-jp?B?ZXdLTzNyZGY1ZEVPMGpGRStFa05tV1pSVE91Nk81d0VpYjBZT2FGUnVZ?=
 =?iso-2022-jp?B?eUlGVjFCdmJSdnRlS3BqZk1vQmJiUUNYSEdjTjEvTkNuMVFVYkFhd1F0?=
 =?iso-2022-jp?B?dXFGTlhJekZBelgwTWYrb2RtTEtta3JXUXR2OENTdjRvMnpCK3l1VGZp?=
 =?iso-2022-jp?B?MUU2WC93eERxTlJaZnUreWNoTm1DeHFYS3lLaThrbVgrV3VzNmlGV083?=
 =?iso-2022-jp?B?d216Nzc2d0oya0h3QXV0SlpKcUlraDQwd2xqa1E4OU5SMUJxaXJnY0s0?=
 =?iso-2022-jp?B?RzBzSEFoQ1NvYkU1M0cweE5qSzYrWFR4WDlZUVNKMU1YQmpyNUZjalBz?=
 =?iso-2022-jp?B?ZnZPdEt4MlVrUi9GY0x3K28yZ2U2RWVFV2dGWS9mUS8vWkwzVG9pTU8r?=
 =?iso-2022-jp?B?Ly9VVFFDaVY2WmdsalJ3OUQ3YzZNNUJNanNTRlRWZ053SDVucFBLWmxT?=
 =?iso-2022-jp?B?aE1yUEVJMTIvN0xQSFpZRXJ3bDZoQWY1cXFyOEtSajlzM3BiMmQ4bTQz?=
 =?iso-2022-jp?B?S3Z4UVVqSjR6VnducEpiZGorL21CNFducHlkWjlvQ21zdCtQU2lZVml6?=
 =?iso-2022-jp?B?c2x3dVlDN09wdFFTUk4yTDNuTjhjQVRWdlV6c1VLMmhoQUw4TlRiOTB4?=
 =?iso-2022-jp?B?RFkvOG1ISWJFTU5GMHBiUURleVNDUnV6eGdWajJVV1JVWDRyVUl2Mmcv?=
 =?iso-2022-jp?B?WThEeWt6MktxNmJ5b2dGUkhYODE1MnN0Z1ZHSFhrZUg3MWU4M0l1S2t4?=
 =?iso-2022-jp?B?elV3UkQzYnJlbnNPZkk0Z3JmbGdobU02SXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61034E05C271281A1CD2FE78C2512OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808a5d54-a9b8-4113-3239-08dc3103bfa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 04:32:14.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYteaN81JsqE32qMTNh26PFJznrvNQRf3fFP4RyRvpXNW5OIUWCZa4KdS34AtF3l+oN9aEU2gMpnY13Z3D8oYecxYRs52tDRC4gyLDbiNo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10098
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 04:32:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15023

--_000_OS3PR01MB61034E05C271281A1CD2FE78C2512OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

I request you to please provide your opinion about creating a fresh reposit=
ory under cip-testing which serves the purpose of creating container having=
 CIP Core testing lava job definitions, lavacli dependencies and a simple s=
cript tp submit the tests to CIP LAVA server. We shall invoke this script i=
n a separate action in .gitlab-ci.yml file in isar-cip-core.

Thanks and Regards,
Sai Ashrith ( T S I P )


From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Wednesday, February 14, 2024 10:06 AM
To: 'Chris Paterson' <Chris.Paterson2@renesas.com>
Cc: 'cip-dev@lists.cip-project.org' <cip-dev@lists.cip-project.org>; hayash=
i kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P=
#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#=
I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Chris,

We got some opinion from yesterday=1B$B!G=1B(Bs CIP Core meeting that it mi=
ght not be optimal to touch this container Files * master * cip-project / c=
ip-testing / linux-cip-ci * GitLab<https://gitlab.com/cip-project/cip-testi=
ng/linux-cip-ci/-/tree/master?ref_type=3Dheads> and modify that by adding C=
IP Core job definitions and submit_tests script specific for this use-case.=
 Do you think the same ? If yes, then do you think creating a fresh reposit=
ory under cip-testing using which we can build the containers and scripts u=
sed in the CI testing of CIP Core functionalities is a better choice ?

Please provide your opinion on this Chris.

Thanks and Regards,
Sai Ashrith ( T S I P )

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Monday, February 12, 2024 8:27 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ha=
yashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""=
#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.haya=
shi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Chris,

Hope you are doing well.

I will summarize my understanding and approach to trigger CIP Core testing =
LAVA jobs.

So currently we have all the lava templates in linux-cip-ci container which=
 are pre-processed to form final LAVA job definitions using the submit_test=
s.sh * master * cip-project / cip-testing / linux-cip-ci * GitLab<https://g=
itlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submit_tests.s=
h?ref_type=3Dheads> script. As I went through the script I understood that =
a lot of logic is involved in preparing the job definitions from the templa=
te specific for CIP Kernel testing. And this script is run with a trigger f=
rom here https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/b=
lame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69. I feel it will mes=
s up the existing testing being done on CIP kernel and shall also require a=
 lot of effort to integrate changes required to prepare job definitions for=
 CIP-Core testing considering huge variations in the final job definitions.=
 And also since submit_tests.sh already with every test action trigger in l=
inux-cip-pipelines.yml, I think making changes to the script to support CIP=
-Core testing will imply that every trigger in linux-cip-ci shall test our =
software update, secure boot and IEC tests on QEMU images which I think is =
not right.

Our requirement here is to trigger a script which submits the CIP-Core rela=
ted LAVA job definitions when a change is made in isar-cip-core. So I think=
 we can a short script similar to submit_tests.sh like submit_cip_core_test=
s.sh and separate folder for LAVA definitions for CIP Core testing in cip-p=
roject / cip-testing / linux-cip-ci * GitLab<https://gitlab.com/cip-project=
/cip-testing/linux-cip-ci/-/tree/master?ref_type=3Dheads> container. We wil=
l run this new script using a test action in .gitlab-ci.yml In isar-cip-cor=
e. In this new script we shall submit only the CIP Core related job definit=
ions which we added in a separate folder in linux-cip-ci container to LAVA =
master.

I chose this approach to minimize the effort and avoid messing up the exist=
ing implementation which is highly specific for CIP Kernel testing and to a=
lso use the existing linux-cip-ci container. This is the first time we are =
testing CIP Core functionalities on LAVA, so initially we started small wit=
h QEMU and in the future once we spread the testing to multiple devices, th=
en may be we can setup a new repository like cip-project / cip-testing / li=
nux-cip-ci * GitLab<https://gitlab.com/cip-project/cip-testing/linux-cip-ci=
/-/tree/master?ref_type=3Dheads> to build a separate container only to deal=
 with CIP Core LAVA definitions.

What do you think of my approach Chris ? Please provide your opinion and co=
rrect me if I am wrong.

I also request other CIP members to provide their suggestions.

Thanks and regards,
Sai Ashrith ( T S I P )

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Friday, February 9, 2024 2:09 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ha=
yashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""=
#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.haya=
shi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: LAVA test job definitions ( software update, secure boot and I=
EC layer testing )

Hello Sai,

Firstly, let=1B$B!G=1B(Bs get some background for this request.

What is it you=1B$B!G=1B(Bre testing? And when is it you=1B$B!G=1B(Bd like =
the tests to run?
I=1B$B!G=1B(Bm guessing isar-cip-core? And whenever a change is made on _an=
y_ of the branches? E.g. next, master or feature branches?

On the Linux kernel side of things, the test pipelines are driven by linux-=
cip-pipelines<https://gitlab.com/cip-project/cip-testing/linux-cip-pipeline=
s> using the scripts provided in linux-cip-ci<https://gitlab.com/cip-projec=
t/cip-testing/linux-cip-ci>.
However, neither of these repositories are currently set up for cip core te=
sting.
We=1B$B!G=1B(Bd need to add something to isar-cip-core to trigger the test =
jobs, and have a way to create the LAVA test job definitions we need there.

That said, perhaps the templates and submit_tests.sh script from linux-cip-=
ci could be updated to be able to run these security tests?
The build side of isar-cip-core can obviously stay as it is now.
Take a look through the above repos and see if we could integrate your job =
definitions into the same lava template style. Or whether you think it woul=
d be cleaner to take a fresh approach specifically for cip core/security te=
sting.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Monday, February 5, 2024 5:59 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; dine=
sh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>
Subject: LAVA test job definitions ( software update, secure boot and IEC l=
ayer testing )

Hi Chris,

Hope you are doing well.

Please review the job definitions attached to this mail and kindly provide =
your review comments.

Doubts:

  1.  Do I need to add these definitions in this repository?. https://gitla=
b.com/cip-project/cip-testing/test-definitions
  2.  I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can yo=
u please help me with this ?
  3.  I remember you installed swtpm and ovmf packages in lab-renesas-cip s=
lave. Can you install those packages all the CIP LAVA slave machines Chris =
?

Thanks and Regards,
Sai Ashrith ( T S I P )

--_000_OS3PR01MB61034E05C271281A1CD2FE78C2512OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:619184302;
	mso-list-template-ids:-1777456488;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I request=
 you to please provide your opinion about creating a fresh repository under=
 cip-testing which serves the purpose of creating container having CIP Core=
 testing lava job definitions, lavacli
 dependencies and a simple script tp submit the tests to CIP LAVA server. W=
e shall invoke this script in a separate action in .gitlab-ci.yml file in i=
sar-cip-core.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> ashrith sai(</span><span lang=3D"JA" =
style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, February 14, 2024 10:06 AM<br>
<b>To:</b> 'Chris Paterson' &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> 'cip-dev@lists.cip-project.org' &lt;cip-dev@lists.cip-project.or=
g&gt;; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B</span><span l=
ang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligature=
s:none"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS=
 PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span =
style=3D"mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(</span><span lang=3D=
"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:n=
one">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG=
 Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We got so=
me opinion from yesterday=1B$B!G=1B(Bs CIP Core meeting that it might not b=
e optimal to touch this container
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-=
/tree/master?ref_type=3Dheads">Files &middot; master &middot; cip-project /=
 cip-testing / linux-cip-ci &middot; GitLab</a> and modify that by adding C=
IP Core job definitions and submit_tests script specific
 for this use-case. Do you think the same ? If yes, then do you think creat=
ing a fresh repository under cip-testing using which we can build the conta=
iners and scripts used in the CI testing of CIP Core functionalities is a b=
etter choice ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Please pr=
ovide your opinion on this Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> ashrith sai(</span><span lang=3D"JA" =
style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Monday, February 12, 2024 8:27 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B<=
/span><span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligature=
s:none"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS=
 PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span =
style=3D"mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG Porting) &lt;<a h=
ref=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com<=
/a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I will su=
mmarize my understanding and approach to trigger CIP Core testing LAVA jobs=
.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">So curren=
tly we have all the lava templates in linux-cip-ci container which are pre-=
processed to form final LAVA job definitions using the
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-=
/blob/master/submit_tests.sh?ref_type=3Dheads">submit_tests.sh &middot; mas=
ter &middot; cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> s=
cript. As I went through the script I understood that a lot
 of logic is involved in preparing the job definitions from the template sp=
ecific for CIP Kernel testing. And this script is run with a trigger from h=
ere
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/blame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/mast=
er/linux-cip-pipeline.yml?ref_type=3Dheads#L69</a>. I feel it will mess up =
the existing testing being done on CIP kernel and shall also require a lot =
of effort to integrate changes required
 to prepare job definitions for CIP-Core testing considering huge variation=
s in the final job definitions. And also since submit_tests.sh already with=
 every test action trigger in linux-cip-pipelines.yml, I think making chang=
es to the script to support CIP-Core
 testing will imply that every trigger in linux-cip-ci shall test our softw=
are update, secure boot and IEC tests on QEMU images which I think is not r=
ight.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our requirement here is to trigger a script which su=
bmits the CIP-Core related LAVA job definitions when a change is made in is=
ar-cip-core. So I think we can a short script similar to submit_tests.sh li=
ke submit_cip_core_tests.sh and separate
 folder for LAVA definitions for CIP Core testing in <a href=3D"https://git=
lab.com/cip-project/cip-testing/linux-cip-ci/-/tree/master?ref_type=3Dheads=
">
cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> container. We =
will run this new script using a test action in .gitlab-ci.yml In isar-cip-=
core. In this new script we shall submit only the CIP Core related job defi=
nitions which we added in a separate folder
 in linux-cip-ci container to LAVA master.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I chose this approach to minimize the effort and avo=
id messing up the existing implementation which is highly specific for CIP =
Kernel testing and to also use the existing linux-cip-ci container. This is=
 the first time we are testing CIP
 Core functionalities on LAVA, so initially we started small with QEMU and =
in the future once we spread the testing to multiple devices, then may be w=
e can setup a new repository like
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/m=
aster?ref_type=3Dheads">
cip-project / cip-testing / linux-cip-ci &middot; GitLab</a> to build a sep=
arate container only to deal with CIP Core LAVA definitions.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What do you think of my approach Chris ? Please prov=
ide your opinion and correct me if I am wrong.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I also request other CIP members to provide their su=
ggestions.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<span style=3D"mso-fareast-la=
nguage:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;<a href=3D"mailto:=
Chris.Paterson2@renesas.com">Chris.Paterson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 9, 2024 2:09 AM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><s=
pan style=3D"mso-ligatures:none">) &lt;<a href=3D"mailto:Sai.Sathujoda@tosh=
iba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B<=
/span><span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"ms=
o-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligature=
s:none"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS=
 PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span =
style=3D"mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#M#P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG Porting) &lt;<a h=
ref=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com<=
/a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Firstly, let=
=1B$B!G=1B(Bs get some background for this request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">What is it you=
=1B$B!G=1B(Bre testing? And when is it you=1B$B!G=1B(Bd like the tests to r=
un?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(Bm=
 guessing isar-cip-core? And whenever a change is made on _<i>any</i>_ of t=
he branches? E.g. next, master or feature branches?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">On the Linux k=
ernel side of things, the test pipelines are driven by
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines">=
linux-cip-pipelines</a> using the scripts provided in
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci">linux-c=
ip-ci</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">However, neith=
er of these repositories are currently set up for cip core testing.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">We=1B$B!G=1B(B=
d need to add something to isar-cip-core to trigger the test jobs, and have=
 a way to create the LAVA test job definitions we need there.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">That said, per=
haps the templates and submit_tests.sh script from linux-cip-ci could be up=
dated to be able to run these security tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">The build side=
 of isar-cip-core can obviously stay as it is now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Take a look th=
rough the above repos and see if we could integrate your job definitions in=
to the same lava template style. Or whether you
 think it would be cleaner to take a fresh approach specifically for cip co=
re/security testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN=
-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 5, 2024 5:59 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> LAVA test job definitions ( software update, secure boot an=
d IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the job definitions attached to this m=
ail and kindly provide your review comments.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Doubts: <o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">Do I need to add these definitions in this repository?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1=
 lfo3">I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can y=
ou please help me with this ?<o:p></o:p></li><li class=3D"MsoListParagraph"=
 style=3D"margin-left:0in;mso-list:l0 level1 lfo3">I remember you installed=
 swtpm and ovmf packages in lab-renesas-cip slave. Can you install those pa=
ckages all the CIP LAVA slave machines Chris ?<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61034E05C271281A1CD2FE78C2512OS3PR01MB6103jpnp_--


