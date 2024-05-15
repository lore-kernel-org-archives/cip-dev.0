Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD29C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 11:11:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.12106.1715771489364187949
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 04:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44FBBRpS3379464; Wed, 15 May 2024 20:11:27 +0900
X-Iguazu-Qid: 2yAbXhlxOExA7APF7U
X-Iguazu-QSIG: v=2; s=0; t=1715771486; q=2yAbXhlxOExA7APF7U; m=PeYrhQqiccJg0hSHL4reB3N6qMHBTxDqeyg5J5C7rz8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 44FBBP6B3955385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 May 2024 20:11:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3KKIL5jTapLDRwwkZgHfZdGWQAUyz30nUXprBOyW9O/ZwO5CH7NztSbxiZCF7ikitG3D/sqpx0rfE0G2CYGBMNdxmGHvykaUe87gI/fJoqC628X0RHH797N58252uCIJFMcI/a+AzdNGCAhbVbxaa5eC0tN+58LepzH94aPD40ORgbFah3+N9T8k2HIC4Q1xv8p9u+RvdXjpYQUax0LwVjPbleyhCMdBW0rCHIUxXjFmE2cDs+RkwDdbj/2yQ+rRbyVp7yFxk9DEQxn/araHU87k1zZkV9WUCRaZLkaveEn632eXnZJoYAHoAk1Xs5TRlKCNuA7Zn0KBy+LsWGcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZOHDWVBazQMdvZmeDla57OzfG+1WyVkmPaXMngOihM=;
 b=P28MHY/DepvulQeSnyxl6O++rAjCUUauFn2LwmahR5tSQWzUGebHBh2cAV17xIuaBeroO+rX4WwSsYCZlmvhrPg+BCOqhd8fKkBifUdq1YVYWpprpuPfBPiErygkcID7G6KF76i9h6SDTfJ7ziGNeYTFweNhEsaLsXlxAbVZCwjfDPTWJ8GwzfdNuyLNaYEmZflPn1j2QlfDezx1+NwU6LGO8fP41rx5iGon7d2TQR+dc9aPlITk8XXGBras65+brNNG1ADeMBjDFNQKLIJUdEVAHKJ1D60iuq+JQ9oAoNqnahz5hO/TAV7Vhw+XlmSp5qduOzagjEMe7YiCP0UCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: AdqmtLnvothy4nUKQBSdfu8qbwxdbQ==
Date: Wed, 15 May 2024 11:11:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB9780:EE_
x-ms-office365-filtering-correlation-id: 44a59ca4-08a7-4711-baf8-08dc74cfc1df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eUVwVC83bEl2azdNaHBaeVY1SzBYajlYc1JQTXR1Qk9VOGdxam05MSsx?=
 =?iso-2022-jp?B?UE1VbjZieVEvY3EwWEpZaHJYdWFiTXhndFh5S3BUV2wzYVpOKzc1ZnI5?=
 =?iso-2022-jp?B?ZkZtRE9zY3A2M1Z4TGg1dllScjF1dlVNUnRMQzBudDBXZGpNMnlFMko3?=
 =?iso-2022-jp?B?aDVjSjU1YjVCdENmMjJyZlZtZ21tM3lWcjhQc1FGUGFxMmo4MzBBTk95?=
 =?iso-2022-jp?B?MGhwNWsvK1pnejdpenp0Qkd1enZFN3UwZTdGeFA4U0RjTURKMlhzdmFo?=
 =?iso-2022-jp?B?USs5K3JvRmxaazJJMWQxNnd4TzFmOVk4SjVENDhCOElscDE2N1owZ0xL?=
 =?iso-2022-jp?B?dnZkVkM0aE1yVWdWNGxzL0NieUFYWlIzRlFtc1FDeUtQZWV3MkRTRVVF?=
 =?iso-2022-jp?B?MFFzOWZYKzBFMkZlTEdUZDNKR0xXcy9WQ05wa1lIbTJOVnhTVUZBODRh?=
 =?iso-2022-jp?B?aUJmVmppWjhlZVhMckxBelVyc0NJcEt2WCt0SHRzUzU5Y05vZDBKNzFr?=
 =?iso-2022-jp?B?SVMySUFTZFc5bkhzaWswcEQ5S0Y3eUlXTGZNN2s0aFd0UHdEVjlGZVZv?=
 =?iso-2022-jp?B?K1JDUGsvSzErYnBZd3FSbFU0N2NVcmVvM1dVTmJzL3FxQjI2cFc4Ky9h?=
 =?iso-2022-jp?B?MjhFUm15L0E4alE1TjRNT3hsWkNUZVBEbG1OVFA3Vmxnc1R5eXJFeHg3?=
 =?iso-2022-jp?B?YTBNby9URXoweXRkdVI3MUxxQUFvRlF3WWNCYXVUNEVBNTRlVU5Dcmoz?=
 =?iso-2022-jp?B?L2g2Y0JWL0NUdzMyZFNkUE1aUGhFd2tEM0NleDRicWNtbjBYQTJmaEJG?=
 =?iso-2022-jp?B?OVY3MkFsVS91OG03N0xiaHdBenp1WXVzOGpTRmRtRmV2Wm9JRzU4c1F6?=
 =?iso-2022-jp?B?dWVMMFN3Ti8zN1BaSkM0NHdQYXEwQ3ZGK3dBT2tRcUd6SVdJaFJpZmNh?=
 =?iso-2022-jp?B?eXVwSEt3Q092S0prenVIUGVuUjk3UWFQM0ErRjJ2cnNYWWd3LzA2OEY5?=
 =?iso-2022-jp?B?d1UzMXg0UThKQjVJdlJ0N0pWUndmWVpOQUxsUklGOUN0UjRHVDMrczhG?=
 =?iso-2022-jp?B?MUZUTVZnMjBiSnRLbko3ck04Z3p4MDdPY0Q0MmcwMnU0dDZ4NE1GaXAw?=
 =?iso-2022-jp?B?RXVKZ3hvUEw5UkgzaXM1TDI1dUNpTnR5N1BwUGg2WW5oZ2tSQVovR3ZB?=
 =?iso-2022-jp?B?c2R2cUpoNlFvYnR5UWZaTm5VVjVZVmcrK0ZrSVQxUHR5dW5sNmwzd1ps?=
 =?iso-2022-jp?B?RnpGVGFuNzNBR0xIcTBVRHh4T3VvQnRoK1kvNHUyMjFZZ1BLWFNkRDVS?=
 =?iso-2022-jp?B?VUZ1OFRoUG9qRVdiQUxxTnFxbnRGTkQzR0NvUkpBQ2wzR1FEajRwblZD?=
 =?iso-2022-jp?B?M0dGd2x0Tlp5b1BPWHNXblllVW52d3JFZEdrMTBNaG91aS9WUUhuSmtE?=
 =?iso-2022-jp?B?cCt1UldON1ZJSkhDWFpPODYreGRmTE1hbzNGRFZXVXNYNXZGTjNBQUZq?=
 =?iso-2022-jp?B?SmNsckN6RGxvM050RWtGYkF3WWxCRFUyQUxXT2tMRjV3QzFJQjBLaXdQ?=
 =?iso-2022-jp?B?UnV0eWJiREZPY2o1azZJWFhNZEdER3VUWW1rUmhKZkJObWVhQW1XUStr?=
 =?iso-2022-jp?B?QlplOG5NNXBObXJvVjhVSW9uVkNCZ2t2QWUvK0FLMEQ4T3ZJQzZDN3k0?=
 =?iso-2022-jp?B?dXhJSDZXLzRobk5lY3diODNqMVRsR1BWUVYrTHBEMUtrOVBDcXhYMzJq?=
 =?iso-2022-jp?B?ZnR5N3VDbFp5aEE5ZDRxNXMwWEFzN1loUW5pTmRyeWZrYXdxeXhHOTZz?=
 =?iso-2022-jp?B?dVpwRjBOK3duNU5LbkpWUDJUck93OVhCRnhOSnZ5TXBvTVp5VjJaZ09n?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SWIwME9uVXFkaklRa1hjb1p5elNYQXBJNktMY2FDWlVCNU9jYkVwRXZn?=
 =?iso-2022-jp?B?dWFIVGY4RFRNa1pUTWNnQXdlTi9vcVhqVS9Pa1o2aWFFY0Jqa3JRaXZI?=
 =?iso-2022-jp?B?WkpRY2huRWNPSkxtS2ZYcnFkblZIN2JiZmNFTFBodjV1SmJ0WGpuQ0lz?=
 =?iso-2022-jp?B?bldKZ3Yyd01rSktDTy9iWjNqd2wrd2NYdWdVU2FLRmRpSXpQWUs4Q2VH?=
 =?iso-2022-jp?B?bkU2a1JWT2FVOW9oR1Yza2dmSThvUkJHSFZGM1ByVW95UjE2eFBtUE5J?=
 =?iso-2022-jp?B?SlI0NmNkdDNvMGtTcS9JRDRIdGRPQmYrYk9QZDh0Tm5MM2QyOHJTMXp5?=
 =?iso-2022-jp?B?d2ZzR2hMQ25mT0VoaklWTS9pMzJycG5qbVJ3OWE0QXZJNXcxWENuWU1t?=
 =?iso-2022-jp?B?c0NJMnNXblV6ckZ6Q0xDWHM5b2FjaE04SHJ4d0IyQkZKYlc1bnNwSUFI?=
 =?iso-2022-jp?B?aFdWNUdlenM4alJuaWU1N25SNHhpaFJBdVlWUFc0SGNOR1oyTEVINTI0?=
 =?iso-2022-jp?B?d3VHNWdHSWo5ejFEMlVnTzdRQkNhVVpmWEZmREdBRVdpTnJRRjJVOVVP?=
 =?iso-2022-jp?B?aGV4UU1MMHdGUURrNUFJM0hhN05PODZ0dWZZVUNSRmRTdzcxdGZRNVYw?=
 =?iso-2022-jp?B?L1FHemNBU1ZWUU8rMjVMUXR4SG1QMnIxVG84aWxvZXFJNnpWeWYwRTZn?=
 =?iso-2022-jp?B?d2J3d3EySmFYR0pyTGhrZ0V6ellhTFFVMlY5TkcyemtmYi9MVnlJYXdD?=
 =?iso-2022-jp?B?QXBjN21QNzRHZmRrYU5XMVIxYzgxK0QwYU14QWZwUlR6b3NmaFNCQUtu?=
 =?iso-2022-jp?B?K0hkQ3IyRGRxZUpqb01MZi9LVldnUDFrZUF2cmNqNXRSczVrbEtkZlY1?=
 =?iso-2022-jp?B?YjB1T29QK0V0V0lueHpmWERKTGNpQ09hamlQVC9RRGNxazhtTkFpT2lp?=
 =?iso-2022-jp?B?T0dXaW9TUUtSMkdHRitubkE5NW1XUVZaVHFpbFJ6Nyszc3o2RVBkWDJl?=
 =?iso-2022-jp?B?eEFhWndJWTMyMnU3blB5elRRVEJwQUhKb3FFSWJnZ3R1VXdhaWlCSzNG?=
 =?iso-2022-jp?B?VHczOW90aitWMkxhSlcxU1RFRXIyR0ZnTk9JQWczaTVicGlhQy9FN1lm?=
 =?iso-2022-jp?B?RkxwU1FwcDlYNmJQdktNb3E2YW9Lb0JRazN6ZGZLNHZYRnpvMmZvNmFZ?=
 =?iso-2022-jp?B?aUZ6bDBBT3pxaGdEL1pqZVlJUWJxWlJOQXlUQTV0bXRyVGVLbXRreG9E?=
 =?iso-2022-jp?B?Qzk2RU9uclhwMWgrbklQTisremFoTUE0YmphcmtGa3hsVklBbk5jd0tl?=
 =?iso-2022-jp?B?QnVxSmU4QzVTMUcrK2NzZ2YwMCthQVN0aUp6TTAvSjhrT2pkblRpM21V?=
 =?iso-2022-jp?B?Smk0VDFZVGk0OVRkQjdWSEl0VVEyRXJ6Qlh4VkppSUxvU0c1MmVBc3BM?=
 =?iso-2022-jp?B?QzNUT3pTY3psbU8zRVorOElZMDBqSnltbmpOY09XTmlMUEFoZXI4N1Ni?=
 =?iso-2022-jp?B?MVBROFg0NFVYMTgxZkgxWHVoS0xnUmJpc1FhSEdhcmZZc3VKd3hpNXVx?=
 =?iso-2022-jp?B?ODdmckR3ait4YXFITGVwL1NRVkdGM2gra2NvdlpUR2Q4RUp0SGZLbG5q?=
 =?iso-2022-jp?B?ZjIzUGJPaVlUK01ybTl1RXVrMkdDd1lxQUo2eFZIM2NNSW9qcTAvNHBw?=
 =?iso-2022-jp?B?VmV4U3ZkMG15T1VNMVVmYVBEcXJjcEI5clUrL215SlR4b3lDbG1CUnlt?=
 =?iso-2022-jp?B?S1FNTENqV0p5UXJUQXhDT3N0RWxoZWdFaTlJNTJUaEpBVGlubkZuQXBw?=
 =?iso-2022-jp?B?OEp0WnIrcmUzRlMwQVpuVUhseFg4VnpscmMvNjZrUHpKZmVrMFk4VVB3?=
 =?iso-2022-jp?B?RWZBU1orZzllWjFDaGk3bEhYc2RyZFZpR2oyWXdTbHBFZ0lnSDd1ZkRh?=
 =?iso-2022-jp?B?R1hqckVIL0hhYjYzd2dlbTJ3VXFLaWZTVVd2d3lLWlNxYWY4V3VwRUxm?=
 =?iso-2022-jp?B?cWw3WTlYdXRWdjA4ZHJWU3VMVjRoTzhUeHRVemZwOG1kVnBSOWYzMTNs?=
 =?iso-2022-jp?B?eDErY1dKZml2N2ZEMUhZblFRa0p5d21ydDNFZ2NjT1MzRUFuSmxaTVk3?=
 =?iso-2022-jp?B?Vit5Tk9rZFE0UnlMbWh4RjVVTkhKTVZ5RlJIeUhhTzZyeUhxZEV2NFpT?=
 =?iso-2022-jp?B?QVJxY1JJKzc0UWFLTE5TcEpnbnBJU3VOaU9DcXI4N3A5L09GZnp1cEJw?=
 =?iso-2022-jp?B?UmQ2UVBXck5weXNCeS80aFFUZEIrdGxUbS8wcU9OQWpDZjlXUFVybXg4?=
 =?iso-2022-jp?B?SUlweERLZTVCRTBLbk1Zbml2UG5oby9YSHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a59ca4-08a7-4711-baf8-08dc74cfc1df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 11:11:23.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHpj0qJpowsVoTVEWMIYhtk74/4HFQAR8Gc59i0R24dv90KCbU7pqcp/OAopFjEmtKdc0MdQcvTgo7upt2vYWynhma6hDB3oFBftuLP/g0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9780
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 11:11:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15895

--_000_OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

Sorry to disturb you with these extra things I need on CIP LAVA Lab. Let me=
 consolidate my requests in this mail.

I am preparing a patch to trigger LAVA job definitions from isar-cip-core. =
Currently I am working on that in a custom branch. Before sending that patc=
h, I have created an MR to update the cip-core-ci repository which is requi=
red to run the test jobs in isar-cip-core. I will assign it for your review=
 soon.

I will be able to send the patch to add test jobs in isar-cip-core once the=
 below mentioned things are done.

  1.  This MR needs to merge build-bookworm.Dockerfile: Include lava.sh and=
 templates in the docker image. (!3) * Merge requests * cip-playground / ci=
p-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/merge_re=
quests/3> which I shall assign to you soon after some internal review.
  2.  I need some variables in isar-cip-core CI/CD setting section like LAV=
A_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privilege =
to do that. I will mail them to you personally. Please hide them in isar-ci=
p-core Gitlab CI/CD section so that I can use them while running lava.sh sc=
ript.
  3.  Since we need to run these LAVA jobs when pipelines are triggered in =
isar-cip-core, I am making changes in such a way that pipeline keeps runnin=
g until all the jobs are done and we report the health as a result. It will=
 take around 120 mins to run all the jobs. We have only device (qemu-renesa=
-01) under lab-cip-renesas. So, I request you to please add the swtpm devic=
e dictionary changes and swtpm-jobs tag to only one QEMU device in every LA=
VA lab you can access. By this will be able to reduce the pipeline run-time=
 due to simultaneous runs.

It will be very helpful if you provide your support with the above-mentione=
d items.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2OS3PR01MB6103jpnp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:245767821;
	mso-list-type:hybrid;
	mso-list-template-ids:-1608333842 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:5.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:812714299;
	mso-list-type:hybrid;
	mso-list-template-ids:1858385010 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1710491300;
	mso-list-type:hybrid;
	mso-list-template-ids:-1365726256 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3
	{mso-list-id:1959749534;
	mso-list-type:hybrid;
	mso-list-template-ids:-1796337264 67698703 -1 -1 -1 -1 -1 -1 -1 -1;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:5.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry to disturb you with these extra things I need =
on CIP LAVA Lab. Let me consolidate my requests in this mail.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am preparing a patch to trigger LAVA job definitio=
ns from isar-cip-core. Currently I am working on that in a custom branch. B=
efore sending that patch, I have created an MR to update the cip-core-ci re=
pository which is required to run
 the test jobs in isar-cip-core. I will assign it for your review soon.<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.25in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will be able to send the patch to add test jobs in=
 isar-cip-core once the below mentioned things are done.
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.75in;mso-list:l3 level=
1 lfo4">This MR needs to merge
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/3=
">build-bookworm.Dockerfile: Include lava.sh and templates in the docker im=
age. (!3) &middot; Merge requests &middot; cip-playground / cip-core-ci &mi=
ddot; GitLab</a> which I shall assign to you soon after
 some internal review.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:.75in;mso-list:l3 level1 lfo4">I need some variables in isa=
r-cip-core CI/CD setting section like LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN=
. We don=1B$B!G=1B(Bt have the privilege to do that. I will mail them to yo=
u personally.
 Please hide them in isar-cip-core Gitlab CI/CD section so that I can use t=
hem while running lava.sh script.<o:p></o:p></li><li class=3D"MsoListParagr=
aph" style=3D"margin-left:.75in;mso-list:l3 level1 lfo4">Since we need to r=
un these LAVA jobs when pipelines are triggered in isar-cip-core, I am maki=
ng changes in such a way that pipeline keeps running until all the jobs are=
 done and
 we report the health as a result. It will take around 120 mins to run all =
the jobs. We have only device (qemu-renesa-01) under lab-cip-renesas. So, I=
 request you to please add the swtpm device dictionary changes and
<b>swtpm-jobs</b> tag to <b><i>only one</i></b> QEMU device in every LAVA l=
ab you can access. By this will be able to reduce the pipeline run-time due=
 to simultaneous runs.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It will be very helpful if you provide your support =
with the above-mentioned items.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2OS3PR01MB6103jpnp_--


