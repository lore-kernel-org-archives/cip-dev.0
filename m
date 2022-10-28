Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AB9C38A02
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 08:25:15 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.93])
 by mx.groups.io with SMTP id smtpd.web11.3980.1666945508974043346
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Oct 2022 01:25:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=nyCjJh83;
 spf=pass (domain: renesas.com, ip: 40.107.113.93, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrw32Y9ZSNaIZ+px1uTDG0vROTBvxEBqB8g5IsFRYi4sJl2HCvrRSLLEb/tMG8umqN+lR2yJhiHowqpHOp0HC/daUBZK701nUw/u0LQ5yU6/f0LuRy95d5zJQieHPni6YFmDvlYYDj/eytHaiH5HXjL6wXIcSVY5Rk62uOZNurZ2vxl4VINF7Jz7nn3LpzchKWYAYYajDJ1ZPze/Pp+OHO+aegZNjyWGzBLCZXhKy9PLnGS+5v7xYPByDN61gkdibx3yanKw+D3eL1TvZl0YHKFW6DJ6FpABlcqAPrTLaoP/49jobPxyan5depbJBl3Q59lhLOY6DXfVqmu6EHCgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6dWT7Lf1kcINFsOeyV4eZrs5Z8hRDmkVtNhlQrl85c=;
 b=CRox6Ie/AjG3qDSe6y2pnF/kB/mQAnAIPX9PGzdYUH4BJL6wQgacZ0b8X7x1P0Y12Wd4HapRsQh8CLwbN/z3YO1kExGbnqsrWLWw2q0meYYa10tS2sdu/1QohN7doXLZmOKrnopenDCa5u4qrJwUosn85A7NUTW37sfE/ZoNIvvuVc6oQqhzRdnETwEXlaHKtB16/Dla6Qx5Zcq0kO+beZXqhLnWy67/rCxICXlp2gZxfn87nMvLd8X+ybTwM6VbU1R7S8FR3cujYPYHtjOZvVNQsWLZpbNfJPrhTfEp9pbgzgfTJvFPcZtQOwky0IeczR/avujjJR0e2eVqH5E6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6dWT7Lf1kcINFsOeyV4eZrs5Z8hRDmkVtNhlQrl85c=;
 b=nyCjJh83ODGNyA4XKQbDPz8XSRSCxKdwLjADgvJPpttMAXsv1gkmEhORxpYGFal7sOL1GCpoeF7Fph8s7WjkrfBAfxI5bQL+sA/mUnFZDch64e8Z1sLWQcpJJorFon5pqFynmN1tE6NrDwTHCD0gyKEJ2PyyyDQzOy5eyUiiRJs=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TY3PR01MB10533.jpnprd01.prod.outlook.com (2603:1096:400:315::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 08:25:05 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45%6]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 08:25:05 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "Adler, Michael" <michael.adler@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: RE: Still random failures at gitlab
Thread-Topic: Still random failures at gitlab
Thread-Index: AQHY6jnGZKP8hW3PWE2hPxBXLR1dza4jeLSQ
Date: Fri, 28 Oct 2022 08:25:05 +0000
Message-ID: 
 <TYCPR01MB10588393CCC20858C0B544FBCB7329@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20221020160844.GA19694@duo.ucw.cz>
 <TYCPR01MB10588638D4BFDFF15F7CB9E98B7319@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221027192440.GA11819@duo.ucw.cz>
In-Reply-To: <20221027192440.GA11819@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TY3PR01MB10533:EE_
x-ms-office365-filtering-correlation-id: 13b68411-f72a-4122-f15f-08dab8bdeaed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZIf5e3gEhJyVlvD6fSNaNp79kjzhI5Qg69TkzNQm4l1XcMZSMGOKNoe7k6k2w+2Yr7QnSp1cpao9znALBbAdeP89SWtoCVBiIxjUhM5g7Q39K3oZGhRaVcQM71ErHXJQThSDpeSKMlP3ZgLukdjiRyi517pliotN816UvfVG3IFgjxM0ozDGA79s5NttwDHVc8DJ3IRk0nj+1QMafFAsJ+TDvD+RZC8Wg7q4DRRWgth+pRI/KQpT99zt0ZAiEv5qGvAmNwO6CObc0iRL+mhE5yRrzse3wmYXsFZSyU9NfTVMBeiWj2ix1Fa7I5oUkbvFk+MJKBWN08K3MsVM6JVDEqsoP92lrubzsqaVAbU5pqlq6yD3gmxMRy52McoLD83KP/OGzx0wP6ISgc5dEbAf9qRMFW9d/6OLRam6EQgbJhsX956oLBcmYYacrBtKujOiKYyrg5jzVZ2hYQJP6ijNckU1lUuNMSngJQ0tEMzyov2cYwx9FYsnPzEI/vW4WU8LI/qZXtHhuy0ayt+kKE4nUvX26T/fnMlHcN3r4E+UZgIXaJ2hkdEnteROO5GhSldMQEqjLUQCsX1dtkoIAdaQNvzA3huXyd18V51E4lUvZNUOBqFexEQd/YT5a4imceWtgOxlC94T4+PVCJSIWmwvW8ma4sqZ6l/bZbxkq7POHraEQf3mONGh8u/Ek0vJ/sX+3l8XMoxn+kXxrdVtVM4mlqu/wriIxUiokO5ZaJgOm2RTzxMuK66+nX2QhrcZFWPhfEpblm7ugxKKQIDK3fKTVtBfWEAFOop+uji8e0qK5Ck=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(86362001)(33656002)(84970400001)(38070700005)(38100700002)(122000001)(2906002)(186003)(55016003)(6506007)(9686003)(26005)(478600001)(7696005)(83380400001)(71200400001)(110136005)(966005)(66446008)(66556008)(54906003)(316002)(64756008)(8676002)(4326008)(76116006)(5660300002)(41300700001)(66476007)(8936002)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?f4gaDbjkSlKqGz1EUIPacLLVY2bc30mbZSKtmjZSh2Mm2Sk2DGb/ePb2?=
 =?Windows-1252?Q?akFcX5WOvlP2xjS3jGr5YqfI8ENV4EwK8GnNXab8cTKca1wdqmVH7YtJ?=
 =?Windows-1252?Q?FrnId8QzpCqFYkLlBzyfEzaphVV7ztwTxUfiO7eeLO281zZhIgbcZEVJ?=
 =?Windows-1252?Q?gyiZZfZTWmwUuZtJjnijzYm5Pb3gczoeWlckrq4dRAGNYyZPj4Ovxwn1?=
 =?Windows-1252?Q?AE/4P4JB8vbg6SVSCQnF/nQT1aLi4RHPsSKsHxzbLkzakUPCYcYu9LJd?=
 =?Windows-1252?Q?rDl3wIkNdF66foWPijD2TJPVRDiuB1FdWryDYTfdHbXwxzgzEIoomoxz?=
 =?Windows-1252?Q?VZeyY06kMomendwJ28uHn7rARiEIs+uydYCQexMvSCms11AvaA4RMCnH?=
 =?Windows-1252?Q?gOu+JUZfz3SSnzczqmJniGY5zIwv1dSbkxUjN51zyXsw9QJGKOk4fcuY?=
 =?Windows-1252?Q?+mjT3Mr6C/l8qjNVnzBww2yvFumnzPe8N8T5RRUKd8pxekCJ88kQP9Cu?=
 =?Windows-1252?Q?AQTyDpvg13ch2qPe3vIsExWF+yAYX+8edeuPaldRrgUfcdLIsRmMr9zk?=
 =?Windows-1252?Q?1Devr7xB2dAQVojuNHiU8JIII3d5kvcJPJ3oZZjz1vwxPMjSh2/f7Drr?=
 =?Windows-1252?Q?hLDiCF1eXRN21CW44N7UwHbfjOd85Yqv9hozTuxnyGnjgyuf9oc+AOEi?=
 =?Windows-1252?Q?BDspNvgbe+0uzNLvdAdhaiJX/EjF2fg1ETYP/6pm8uVs83utZW4uMNDg?=
 =?Windows-1252?Q?tzaOPZ8c73K9GBbBcM/cMYYvX+rhHGK8Unk3WCwOV7e4Srfqb0tVFY4v?=
 =?Windows-1252?Q?2PKO0L8QViXBqYmE2SFeVM/yw4lLBVJwKv80cbZNFOeFx5ratIknGou7?=
 =?Windows-1252?Q?/+XXnn2TtXBsgNzzoEQ2zqJdrF5KmwE5KtfuZ4B2rO4disIxh0hN0MMC?=
 =?Windows-1252?Q?7yx9SLwfcL5A8h0qHiOLZrPidwFdms0T47famCwJQCYOGo6pKTQOEHSV?=
 =?Windows-1252?Q?OGrRN7Sx38I7gfid/Dem8BYZsatkyfayyx2+oDrk2f3YDP2g8rS8iLQg?=
 =?Windows-1252?Q?zH9Fweyfwah5nMdHbIDaQeR4wQk2yXC2hZuKCu3ZAWlE7MCr0Iay9M/h?=
 =?Windows-1252?Q?0O2i8MRdiyOJ7+hlurSTCW8NZ45SfPRuF8gYiEV7T73Y6yjQ+SQqsoew?=
 =?Windows-1252?Q?ZJdU9ZPGcBTXJPhNKVt0d9d8ONPiNm6JywchH99/LLy4RIueXDr0C4Oc?=
 =?Windows-1252?Q?8gFKHmgbQyzNtrmVobQRQVkkDL134CMBBjO2dPLuPtGvc9uTiFLnxtMT?=
 =?Windows-1252?Q?mn5p9njQzZB+hVlgu2LTYXFj8r7uNXMV4bbJ7/O38pahR4Pn7g3X4xzM?=
 =?Windows-1252?Q?2C4kC/2wlkm2U/HDrX7VvAiN40uPfTx4heON7i5KSLdWpY/1q7ZPQfuM?=
 =?Windows-1252?Q?yku8qM3o/1tEK6AlReruK6tIfU2phTsSRzM00uAOHvotzjosoPBtf7K6?=
 =?Windows-1252?Q?1Vve5sI3JM2kgboZ/qs+NrIS41p4JOQq7KbA3uXBoOuoaSQ9MYb6R4aD?=
 =?Windows-1252?Q?94VMHnI7hBueJyqI2ry+V1pD5x53kbCM9ltZq7JueoZnRhq1dXlj0Zhd?=
 =?Windows-1252?Q?e3qATgdw8Gy9RNWqH2OncIMuke2rLyZT7LN4bFhvo2oDNyUZEoOvLAH0?=
 =?Windows-1252?Q?s4hHfbGT5IFgbUumZncNNZt2omdrapG52cyRcRRM4hwSu3EtVSNr3w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b68411-f72a-4122-f15f-08dab8bdeaed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 08:25:05.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nzJx+JDOVHetWWKca0Tw0weXcELywYO8CmDk0lDg0vVG/DLZFbI6hfF1V30PjCfbWztHeEMLcxCLHrE0Ow95NlC8PaYWM64S6V75jcMw9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 08:25:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9884

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 27 October 2022 20:25
>=20
> Hi!
>=20
> I'm still getting random failures at gitlab. Is the info below enough
> / can I retry the tests now to get real results?
>=20
> Thanks and best regards,
> 									Pavel
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/679070235
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/3238998916

Thank you for the report and links.
I noticed similar issues yesterday as well.

I'll let you know when we've found the issue behind it.

Kind regards, Chris

>=20
> Running with gitlab-runner 15.4.0 (43b2dc3d)
> 2  on 1665142213-cip-project-small-v9-project-gitlab-runner-85dctt8xr
> Uf_MsYPS
> 3  feature flags: FF_KUBERNETES_HONOR_ENTRYPOINT:true
> 4
> Resolving secrets
> 00:00
> 6
> Preparing the "kubernetes" executor
> 00:00
> 7Using Kubernetes namespace: gitlab
> 8Using Kubernetes executor with image registry.gitlab.com/cip-project/cip=
-
> testing/linux-cip-ci:test-v3 ...
> 9Using attach strategy to execute scripts...
> 11
> Preparing environment
> 03:07
> 12Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 13	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 14Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 15	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 16Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 17	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 18Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 19	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 20Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 21	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 22Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 23	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 24Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 25	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 26Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 27	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 28Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 29	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 30Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 31	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 32Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 33	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 34Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 35	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 36Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 37	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 38Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 39	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 40Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 41	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 42Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-
> 0nzck6 to be running, status is Pending
> 43	Unschedulable: "0/1 nodes are available: 1 node(s) had untolerated
> taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes ar=
e
> available: 1 Preemption is not helpful for scheduling."
> 44Waiting for pod gitlab/runner-ufmsyps-project
>=20
>=20
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

