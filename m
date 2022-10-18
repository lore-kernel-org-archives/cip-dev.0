Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB5C4332F
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 12:07:40 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.137])
 by mx.groups.io with SMTP id smtpd.web11.5823.1666094853727408192
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Oct 2022 05:07:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=BZe2qluc;
 spf=pass (domain: renesas.com, ip: 40.107.114.137, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEPk3g74VPvCSsQuMwlZdxwyY/PdYW19uRrR3oDGVZN3txRdWFlMoJv72QY/GHkE2yJPy4judaUyOJlP897rqqH+JTGdzO1XdiKlRPqXxuyZ/bnvAJtfCCDa0dT6cWbIKh1zEAD2TQ4DolY6nmv4v7e2J//qOG/Y8JLlLz7VSODpZPgtWMucMmw73PNasN7ZHCNGty++e0wfHO8V56TiRkDu199OvWlZT1QCSbgUR1jK6TsdUvmp8QuH/EYgUC1Jat6QvLohQB92K5+pBXhHPMVTr+nRNLTthA/0Bw/TA8RzpkdTmiRgz5Lau0EXOJzCTKVAqnEhx/7uSLM3mf0TTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJiqCr2ijhy/2p50od4Hfxb0RsphqTcWi37bTn7nH2A=;
 b=Co5yOy1r0/uwT8jQdYt9+bMPMr0OGA7TJ+hMCFi/XGHfkktz2tDV1YQzcT3y49GliNPe0DktY47TdEjEOm4ORWY6e6FIWCmXNSByBsDpP8B7LVzheGcjVQ9FqJ+DVKMlXbPMeSjmklhNd+moqZFcrlpeV2eCLkYZXuglRG/kBu+8VzzzrDyaO34BoqKC1geeGXUda/1wLbPWfSx385bW6kIxevBr/XiJNqwcvnHXu3tJXWD3H7w3o8zeq3S33yh6tciQj6yciZ/N8YZ23ZPJnN9Szn/NQDkrZPxoDW+CW5gjKPKa6GZCYatIEaJEP9fohznIPD2yAxuRxxv8xttRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJiqCr2ijhy/2p50od4Hfxb0RsphqTcWi37bTn7nH2A=;
 b=BZe2qlucTIvKG8zrck8Qv1UuyiX1D42IAt88b+zW+QzBiMIhxXWl9c/KsfaEZHQbH0JGA/wT4hRD8m8ISWN3IHtA83ZjTKQWEFFVvEB/KxEKhKYa9Cdh3wt6su2u0b6CaU8dOqqMvjo7Q8hfsGqU6PjNoze2Gq+eNKcXRSEJtM4=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB9307.jpnprd01.prod.outlook.com (2603:1096:400:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 12:07:29 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 12:07:29 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Tests run on CIP-LAVA platform
Thread-Topic: [cip-dev] Tests run on CIP-LAVA platform
Thread-Index: Adjh9pXyvPJeWbcCTVG87YJuWZoCXgALVGaAADD6yCA=
Date: Tue, 18 Oct 2022 12:07:29 +0000
Message-ID: 
 <TYCPR01MB1058810A48CAB2D90723DBC03B7289@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <6f438000c8004b20b927ac2d992238dd@mentor.com>
In-Reply-To: <6f438000c8004b20b927ac2d992238dd@mentor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB9307:EE_
x-ms-office365-filtering-correlation-id: b1b0d190-381f-4ab4-ac5d-08dab1015491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TxRmib/LQOw3X6fIQfpzX03BA+bMNyUtyQyYqiTxFHiZcWOqO+b0Q/zuHyam6oolBUbkTDpYqp9i15IejT6JjagxgUxioKsN2pPNtb4tc3N39GCoDZHmz2r1gPa3L0JM3lm6CwLJ/FAGg57G2rIi4FEGMdn+3VymntBrp2VeWmRzwvmit59t8+Q6WDZFBHihWqSfk3lVpMmCcgGtzwsKgyltEiLs0B0tjJCljoWia9kj7Y44DNqq9mz00joR+QY9WyDLqY+EuNtIj34qyVxGF35NOYOtnfKYU9dsz9As6K/8InhKHiCo/bYd9YmkjcU6+3n7n/tID8k9ghCZheCs3SKvNarM6fEjBbT8oTqNFHZSAypIzPcoj0htqeZX+I/iXaHWU1H+6Qwc8DmOCtwQNH7FRd6bMjxJpSvXvvvpNx+mdlAe0QmQS1d74X5BB0EWT2USa/8B530P2de8AYXynwFEKrLhhdIke+baSJxMTiOILA9Q8P8oMJURtkeKHhVVI+qveYh7KKSRN6Pmw/4n77UGk4619/lDvExSru0iILy1P7RruOFM+5xZF0xhBdloQNshQFNT7CYPZPKYEl0gVemr3ilrUhMHoBARHjYX46P9MbMa7GnC0oLC+6/Exo0zJhK5Ha5ZxE6thRf585y1sjl/SBrdDF4BHlQsjrU3kWv2AnYKFv9h5AfGZyQRcXfo/WWryJK/71YbuCJ66KYtyULByXJIiYuo1bGXARZAH17lAZ3YMsrHh7B2lv4JfjtvWV5JLaELwbmsXQ3q8Zs74tbiMcVvThyKYWEm0nGLMejnAbtyfGVkIfs0hnJe0mun4byK4a0LumlhO0JvemyyRg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(38070700005)(122000001)(478600001)(71200400001)(966005)(38100700002)(33656002)(316002)(186003)(66556008)(66476007)(64756008)(8676002)(66946007)(6916009)(66446008)(76116006)(6506007)(53546011)(26005)(7696005)(41300700001)(52536014)(8936002)(9686003)(55016003)(86362001)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?YhiUqe39di16LtUFq8aP4MEl/3s4zS1wBpT0EuxcPCSv578Ufqw3CKEV?=
 =?Windows-1252?Q?eDdl2u8c0AuuquokPxaQo+u7zLbcG98fssYhIyi9UfeomEpAEmHrVRHg?=
 =?Windows-1252?Q?ALFs6OSqL/9fX47ZK4OFJom+onGPfenB++WCxi/ZSubMCDIDT0f1F25+?=
 =?Windows-1252?Q?xWlwhwscCZeb3FjE0ia+PvrnqGonarsSkPuU0d6veb70UhnfKksF+8JZ?=
 =?Windows-1252?Q?L1dSKSSxYEOAodhoTz/b/B/mEgloR2VXLn4lKEi90HadsBlqmpGt2GKA?=
 =?Windows-1252?Q?WFHrkTOUYjSA75QhZcIxT/DbpY5nrdgnXTlOyxxF2OxzeEBzx2KcJQst?=
 =?Windows-1252?Q?JzK8ctlMiMHO+hd1UWPOA7TBX/9mA8ol23n9/OjeZ7E6EDgcEjWl4MSW?=
 =?Windows-1252?Q?c18pP+EUAVJll5v4Bm5F1MsngQYea87q+7YnedRYrFEbICSsKfxBflY2?=
 =?Windows-1252?Q?gml5+I0ZcfBMh1eGV0a0s1dX2zUVeYoe4z4Ogz/aKrwJFQ2Y8MsiwqE+?=
 =?Windows-1252?Q?W3aArkbnzBlHwSzherRCVNfB/blkd/Qui+k4ynWH/1XsDkbAce4repeV?=
 =?Windows-1252?Q?W+b28h1Otbl1SYlNJHrl8YmttDnT0k0hoHM++fQDrQEUaBru8shQQotv?=
 =?Windows-1252?Q?yxdJIpckAW4PAtf00MhsPZX6f3nqUg6X6pptWcigSQgvZvTuU8ePhZ8I?=
 =?Windows-1252?Q?btBlaLE0td53kbQ/XQNpRTGSn9mXc4zLH2Yywfu4IYPEAldciAKJmczQ?=
 =?Windows-1252?Q?5epkUByiKYdP3oLm9P6V46CjCeIW3uMLfUUNCvge7BrgyNl/PFwCpTdp?=
 =?Windows-1252?Q?fAvsHPfq4no+pwPCPGI8guJkgtwDkZmJiWs5DHfI7QPmJ+23lhVva3fg?=
 =?Windows-1252?Q?lpY4OcG7bGQywnlHXj0XaLfAGOhV8ecfiwVTn6OqICKZHGEAeiVXDUXm?=
 =?Windows-1252?Q?K6C4VhJkI/FSMvOvGKSaqtPwJNlBuIPoF5UhgNXojyV931aiT6PHjFOc?=
 =?Windows-1252?Q?AWyKwuGVMs6dc8UHd8FbCQqHHhrI4WgfECDlCZ3v+mlGvbLnalpdGnnF?=
 =?Windows-1252?Q?630J3WNNEHGwOVUaGHX6jngmnd6KbvkZUDpQcQogiDNUuyoyBPceso7D?=
 =?Windows-1252?Q?A8WHtTcMObZfOVFwd9hmkTslQNMscU3BFnRnuCVdw/+JKvzgcr4YaLJ6?=
 =?Windows-1252?Q?ONl5sOYIvbi3gj+v1XjalKiNU4muMm3+M4my0m+ANj8o/QSwfYqIBvgC?=
 =?Windows-1252?Q?+93Ur7W9ubCRJgwD1471msos+e57mZKIHrt9uPWaV4zxZ+wOglNNFI6i?=
 =?Windows-1252?Q?XXEWMSGwiqc8qi67VnqZScSC2GewHPVzWqhXM7kvsTNOFp6YHkM6A+nB?=
 =?Windows-1252?Q?/bpfRDjezyVf8L49wue0fTywHHD6A5X0KcwT9vH8m+nsg67tE7y4Dp7t?=
 =?Windows-1252?Q?JZJ1K5wJ/DL1VXlql2nJVnGe1FGphTZ0iTNL8dN3noIldgnnTR2r6CMz?=
 =?Windows-1252?Q?OnjUAaS82pome0GP1XsNciiLL3GPJ0CRWRi6jrWE/egoMQNk3iR4fc0s?=
 =?Windows-1252?Q?vebH2WMOnSrKMCBifC2fDOLMn+gMFP+kstsZaEo4PxJwZBnDxyphcVjP?=
 =?Windows-1252?Q?TviFvOcENPqbRb1/fuHV1+JSuGGWhH0QJqkQS9qCZwESEa2+smJtiJtE?=
 =?Windows-1252?Q?xA5yaS1MO3mAeWkKnzikhl/PARIE1NrtXGpqtbVHkMqqFdiegsjsuw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b0d190-381f-4ab4-ac5d-08dab1015491
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:07:29.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gViKc5JU5epZFa07S14/2Zp5MTdNiXcNVedlrlKMnvrYfQ4rhofU4Foda8MxveZ57BaKNL8MPGaH59chbPDdaHR+qJZ7TCFgljoV8D+mpWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9307
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 12:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9771

Hello Sarath,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of P T, Sarath via lists.cip-project.org
> Sent: 17 October 2022 14:01
>=20
> Hi Team ,
>=20
> I can see in Linaro/test-definitions (https://github.com/Linaro/test-
> definitions/tree/master/automated/linux) there are
> 123 test-suites are present but only 4 test-suites are running on cip lav=
a ?

The tests we currently run in our GitLab CI setup are listed here:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cen=
talisedtesting/cioverview#when_tests_are_run

Note that in KernelCI a lot more gets tested.
You can see the latest testing run on the v5.10.147-cip18 release here:
https://linux.kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kernel/v5.1=
0.147-cip18/

>=20
> Few more queries I am having regarding this.
>       i)   Is CIP  running the full QA of Linaro/test-definitions test-su=
ites in any
> other platform ?

We have only added a small sub-set to our GitLab CI testing.
As shown in the links above, more are run through KernelCI.


>       ii)  All of the tests which has been run in the LAVA CIP platform i=
s 2mins
> duration. Is there a particular reason for choosing these much duration o=
f
> tests ?

The test length depends on the test.
Some tests for example take much longer. For example this ltp-syscalls test=
 took 1h45m:
https://lava.ciplatform.org/scheduler/job/763898

Kind regards, Chris

>=20
>=20
> Regards
> Sarath P T
>=20
>=20
>=20
>=20
>=20
> From: P T, Sarath
> Sent: 17 October 2022 12:34
> To: 'cip-dev@lists.cip-project.org' <cip-dev@lists.cip-project.org>
> Subject: Tests run on CIP-LAVA platform
>=20
>=20
>=20
> Hi Team,
>=20
>=20
>=20
> I could able to see there are few tests are running in the CIP LAVA platf=
orm. I
> am showing the list below what all LAVA tests are running in the CIP LAVA
> platform.
>=20
>=20
>=20
>=20
>=20
> Test-case
>=20
> CIP LAVA job link
>=20
> Status
>=20
> Comments
>=20
> i)                 spectre-meltdown-checker-test
>=20
> https://lava.ciplatform.org/scheduler/job/686074
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.
> ciplatform.org%2Fscheduler%2Fjob%2F686074&data=3D05%7C01%7Cchris.pate
> rson2%40renesas.com%7C628a9bfc449c4f32dee008dab03fb7ac%7C53d82571
> da1947e49cb4625a166a4a2a%7C0%7C0%7C638016084971574185%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DlHQbDUMj23SLAG2%2B
> qPEY1CtjYQ68%2B59QcgSpsGIg6WI%3D&reserved=3D0>
>=20
> Not run
>=20
> Reason of failure
>=20
>=20
> ./spectre-meltdown-checker.sh: Permission denied.
>=20
> ii)               hackbench
>=20
> https://lava.ciplatform.org/results/634343
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.
> ciplatform.org%2Fresults%2F634343&data=3D05%7C01%7Cchris.paterson2%40r
> enesas.com%7C628a9bfc449c4f32dee008dab03fb7ac%7C53d82571da1947e49
> cb4625a166a4a2a%7C0%7C0%7C638016084971574185%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000%7C%7C%7C&sdata=3DuM4%2F3rQ3QezNTAegpfi%2BjhKB
> %2Fy6VgjhHQ1i0yjbHXoY%3D&reserved=3D0>
>=20
> PASS
>=20
>=20
>=20
> iii)             cyclictest
>=20
> https://lava.ciplatform.org/results/634097
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.
> ciplatform.org%2Fresults%2F634097&data=3D05%7C01%7Cchris.paterson2%40r
> enesas.com%7C628a9bfc449c4f32dee008dab03fb7ac%7C53d82571da1947e49
> cb4625a166a4a2a%7C0%7C0%7C638016084971574185%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000%7C%7C%7C&sdata=3D%2BsVty8GVrmvdAcL%2BXOXQv8s
> N4FiAJgnPDqzEfIMXCIo%3D&reserved=3D0>
>=20
> SKIP
>=20
> Reason of failure
>=20
>=20
>=20
> $ ./cyclictest.sh -D 2m -p 98 -i 1000 -t 1 -a 0 -h '' -w '' this command =
is giving
> =93/usr/bin/cyclictest: unrecognized option=94 error
>=20
> iv)              cyclicdeadline
>=20
> https://lava.ciplatform.org/results/633692
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.
> ciplatform.org%2Fresults%2F633692&data=3D05%7C01%7Cchris.paterson2%40r
> enesas.com%7C628a9bfc449c4f32dee008dab03fb7ac%7C53d82571da1947e49
> cb4625a166a4a2a%7C0%7C0%7C638016084971574185%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000%7C%7C%7C&sdata=3DhzllFtkK7G6mNHHfIO%2BsSb7pAGd
> Nag5mEtAx0FnH1Ek%3D&reserved=3D0>
>=20
> Not run
>=20
> Reason of failure
>=20
>=20
>=20
> while executing cyclicdeadline.sh getting an error like
>=20
> /usr/bin/cyclicdeadline: invalid option -- 'q'
>=20
>=20
>=20
>=20
>=20
> Is there any specific reason why few test-cases are running through LAVA =
?
>=20
>=20
> Regards
>=20
> Sarath P T
>=20
>=20


