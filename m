Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFFDC3DA64
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 07:29:25 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.web10.1938.1722929361595245146
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Aug 2024 00:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jVIzulNK;
 spf=pass (domain: renesas.com, ip: 52.101.229.30, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrinYgAWgzQAHDqC8L/h/oPHTR0tFPQ1jqkju9YRrpbB4RD2hkQjMiRp9PJfnSB4w+wXlf/XTOZ7TMMU2xwRpIdYrTQOIgefBuN6fEtQd/jXR/zM4pnpnz/m5TlFra4uk3icUSBFcFBxrgQAlJKJfNmWDVaogeQEd5oDZmF7LgElsxL0xbxFBjU73SeWMp/63n84ugDBl4tTTmQGjlif3vVgqaDyrBo7ZkL56bxIs9bJUe6ubdHvH6DP2H9b2eaTFZvIBQjvQzpoX7GVHGmfQlFsKZXhBs9RlxXTMoo49wYvoGAA8zECoihgWwKDa4wIfsGVrO9Ze7l/q3RupzHX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSjxxVlDaojyC5GWlkB+FuYBIx614284Hq2dHZbLxf0=;
 b=Q+qwndJWyNE3hs5uinnpB3ojEtvjgiLP67abNraifxKI+TnJsTOsdQog5JQ4xkcHsFHcQj8WQaQStsRuqz4aj3hqFRQjwhsY3CCfsGHOodtjEm66SpNEba7ILVy78U0bsT1gvCgDVK27ZtUkRzjeoA9VhYG+bF/4epjKF55i+Ty5RtN1oMFoyxw7k4wkt66MRk38gd+Bs3lYv44xpstO6v/bBaaipDqPwKlPFcjeI4hU5ZqaA3ifRP1ZU9hsSDEJM2zmdyY9+9Lu4ZTTfVKpGoKJV9VSOflJIziwSQumSxntW10+G2aSdC3OOPbYKrx8F3fzbn2wftO8A6vRy1ydNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSjxxVlDaojyC5GWlkB+FuYBIx614284Hq2dHZbLxf0=;
 b=jVIzulNKT64bcbkPv6KZDw/ick8QmhTGY2VfHrb0BgMOaGU/SK0RzD83BONrEfjoFVdtMR3K1QwMU508QFEGnI6+DRgQL221nCAFqkAMG37jbJFPiHNgR7edfVSjnay+4T/wStTLryjWU9e+R9yjqahzaMjqwrEp0eY8gON4n/U=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TYCPR01MB10198.jpnprd01.prod.outlook.com (2603:1096:400:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 07:29:16 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:29:16 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: CVE-2023-35827 tracking
Thread-Topic: CVE-2023-35827 tracking
Thread-Index: Adrn0lZIcs9lQIsMTjm6o6fbAOTl5g==
Date: Tue, 6 Aug 2024 07:29:16 +0000
Message-ID: 
 <TYYPR01MB124023222835A195286BCC954B7BF2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TYCPR01MB10198:EE_
x-ms-office365-filtering-correlation-id: 024ef1b7-dfc3-40cd-ec3e-08dcb5e97a62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?PDrjCv3V7m97cgkmrJ+IWZ2gGMpL5sh8eegpszHqy7x+k/+ZFF/RjkrXyj?=
 =?iso-8859-1?Q?QnR/n7m7P2TQLtegfHQhLytp4CovML6CNpU/NP8718ft5fLP3tMbmeHERS?=
 =?iso-8859-1?Q?giRdQ5nn5jPyFcgsw16Vjb21J3k1ixv+NadnK6ZoMBhUC9ziADId0yNfHI?=
 =?iso-8859-1?Q?Bk70Skn6sfhu7gUD2aqPTLdMHwaRSEKMPbOEBlkq+4NvcJ3WreSPbRkjN7?=
 =?iso-8859-1?Q?lU+oOmZTtFEPTwGNTxVvS1v7j9HdI5u/9xt3PG24PI12bobV2RmawwJo22?=
 =?iso-8859-1?Q?64Zn0w0IaXx/UcvmmYj5t1GGUyLGirtKrP6AsGxUcMMDpuSgzwiLROGPtQ?=
 =?iso-8859-1?Q?ht4CxL8+DQv8Nb7qXGic3OBci86IIhVHFIVm2qAC1yvgD6VDmhOjOuMtRc?=
 =?iso-8859-1?Q?0EMn2aK2SnPtMTmdUFbWMv/uKWgWF++1PJKN5zpxu4Dk5yt6qWZtqrSAjm?=
 =?iso-8859-1?Q?COfCqrJ9RYwCuy2S2G+bxp/YVQlJp0rys3d6Li78OYjrBr4HwMeKqm+UMw?=
 =?iso-8859-1?Q?tbaqpXZng0oPSdCIma1cIfUoxbCewrwx4WAE5ZGdOEx0Prlxz87rSs+Bpp?=
 =?iso-8859-1?Q?T+ZQmUr6mFxdSMy07WZF605gTVGfx5p5SDfDE2JHD5PYCEQOyfyDEhOnu+?=
 =?iso-8859-1?Q?ebA3mqBZiDcehz3YMVf1CrsS/WPmJdwpFGu8wNcNXYxjbtUfge5X0WAFvG?=
 =?iso-8859-1?Q?DruuvF4KoR37vkeoYsxTtpV4GU6zM0hLgmGo7pOHbzGFFgxfx01gvTSUoq?=
 =?iso-8859-1?Q?Rg95BV2gc+9Nz1Ct3UzDVGYotVUGPGAlNZZobuYucF389+ZXhGsQhoNYRC?=
 =?iso-8859-1?Q?tHeHYNW4kjw8iCqJbRdj9obpUowkWQBjJmw4M+cY1I4m8cv7BuOUxCQm4Y?=
 =?iso-8859-1?Q?YGp4WimpTZw9pCbPrQ1M+rtsGTY+lbfGL95Ww177KgORI94vuu5lpDH1VS?=
 =?iso-8859-1?Q?M/d5+iafyaV2EY7Q5kqaEmzTgDZoVDa6HqqfIdpZMFxW7ckaX97L7+IQgD?=
 =?iso-8859-1?Q?cCTvxQ7nmS4jGWXFx63QRTJYRz7NT81TA/+e0/TY8/dZSzMiJ9zQKxcPot?=
 =?iso-8859-1?Q?jOCS6PYmzYzVuuXC9pEr6VrNf1ylS9tubs4U9OZ6gqIJOl07K5U4OlZe/M?=
 =?iso-8859-1?Q?RcgRTTLDpjGvN1iSK6z7nc5Jt6dNkcuYzum2oNoQnweRKPPd6gALSSGAAi?=
 =?iso-8859-1?Q?k2/WZ6hBWZjQTvnDUAmBvW8lQvNxQYX9abYpgnuM0VksRcTj9LtQra/Lxo?=
 =?iso-8859-1?Q?pTDKX54VapfMWKhwyB1tlp9OfddgroebsM8doeWQa3kyaGVCVP+8tujsCr?=
 =?iso-8859-1?Q?Ao/CUBH43plN5EzDlMgVDyopjGHdFTJ4OlxdkKuACn05UIHrDdjHQTe1RF?=
 =?iso-8859-1?Q?fkBQQK6zBHqchZJykrAoBzS1nKeHppcdINPfrnAYCIntr1DZFhkkY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?xg5SXMtrOm2E+ArHJ0uj+K+0OIJijO0JS94xm8Cz6o7jyCLX+bf9iQKGqj?=
 =?iso-8859-1?Q?f1cjd26sq0i7m9glCzN55Xk48i9LPi7sRgHD2IdFpRHqvmKNuLDtnQhoZh?=
 =?iso-8859-1?Q?13bRDofqzo/WAfz1PhzmOWwc2khcYVrC/IoujqaV5A8Y/r4QgPWjPr+OIi?=
 =?iso-8859-1?Q?FQ140Vb/Wwt0vW4qO06o9hMUFID0Bhoi1tCwPNf9ychc8gAIC7m5O9KiiW?=
 =?iso-8859-1?Q?Pojc1fFd0x9NPs3ZNdIiIbRkE6JYpYxIJjoft+JlmaO7oGO0Dlxxlnf4xY?=
 =?iso-8859-1?Q?+B9xZzLqd+X418RbUPDE6Z3e2EOlgmB3oTyNnghi3ZTtBdUXAdq9NbxXtW?=
 =?iso-8859-1?Q?mFjbXy17Ujs4uHAYTNkWdUSnrQf5ZwsMRrZKtKE53PxPUsvYsfsNC5cfqv?=
 =?iso-8859-1?Q?gj5PbZeEXklqUmEHpNw0OIp1kRjkSZGOglfzYmMr7XOZJpEIRG3la+NKQP?=
 =?iso-8859-1?Q?yONALyBeGsHhb76vIXq1XXj36N1NSp9vrt+cpsXWvSHQGUEy558A89r/P/?=
 =?iso-8859-1?Q?He+VrGQ4frJPq/C2Kz1MUeJyd6ZMDNAGfhqHtGzM4J2nDdEk5p1kNgx8Nk?=
 =?iso-8859-1?Q?Jj0mOJpax72P9ToLJUd7hi76dDmpc+QitRF5Keul5Z+QD2rV8pUPwN/d4Z?=
 =?iso-8859-1?Q?CQQCJs7yKjOthuLD8c7PBhIOiKkQ1umcn9NOvilEJbxa3BvhtIc9KGg+Ss?=
 =?iso-8859-1?Q?Z4+2RuWS+iViPicjrskWtQCPqrPWu4+6388QIydQVZB6Umj5XIe+u8j2MA?=
 =?iso-8859-1?Q?2YFQTxIpZqgV45Ull/C3F4hZurQIYQRmaqgsKTkcW9cwWJeS+tsihvEmpc?=
 =?iso-8859-1?Q?Pl9qddbrJj6veuYzXTXPTvrbsFSPEHI7cexnAwEIEMF+q+n1mrpMq7D1n2?=
 =?iso-8859-1?Q?bF6/S1X8IgsikHXntdqbVdvE+LMuwrapbRDYGUNc0vGqNqSrhbk6eVD77W?=
 =?iso-8859-1?Q?jKNaDoIAxcsT7lCvu5aSZV37hxpQizAvxe9EuENPS4+3B7o7QhhW5NddjV?=
 =?iso-8859-1?Q?aeBdd+dIN79vxAYUIdr/X4Yqg4itjDqSqj3f9+8VJcTcwGR2wM9yEK8Y2F?=
 =?iso-8859-1?Q?dzJJTjMfkIB/HuTwF9JmuW9TO5oD0DXNyDYvXD3xNMXsZ37AH27Pe63WVo?=
 =?iso-8859-1?Q?+kksH7wcR3tAVcZluqA+I9iYLWRfDzWeCToDKAd0/HF80g0tgxmVLvutD0?=
 =?iso-8859-1?Q?+wZUZUy0XL0tjVHJZrrGyxcraAPJrqbwf8PFwD4vqtvjOZzf6ME8BrOadq?=
 =?iso-8859-1?Q?+PCf7sgQ73Si41zMJTiUHG2k6j+SCZ3Yk4fyqetUrDS5/W3PMDOKNJVKhp?=
 =?iso-8859-1?Q?TOSdxGC4w3gdcZXd/4GpgDJs7BR+gltA3caWvl+gRQnuJOODi1wjyHUfi9?=
 =?iso-8859-1?Q?eE6tejMg2V9rs5y3hahEshYex6Pffq3F6FDW066FGTzMNCY77+aUkHF/NN?=
 =?iso-8859-1?Q?n21FrRs6C9dC+LWl7cI4/EdM5K/xX3Z+rAqc7iWKzvgXqfttaoswYA9YJx?=
 =?iso-8859-1?Q?65FZE33UaDEqod8B1YMOn5ck1F6mjSEgQvD6XItcDM8BGoJX0L9FhBo1Eo?=
 =?iso-8859-1?Q?I0Qddm4fJz4q5Uem9+ZZculqqzSO8bmVpzY+AzDI6vFKWWNLrwV7KEfCoC?=
 =?iso-8859-1?Q?cNpKV2ggYyE58YKuywnNA6w0/6PYdbXwEXEHAPhuITbFWtQ1XZjja7gw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ef1b7-dfc3-40cd-ec3e-08dcb5e97a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 07:29:16.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GGvHYbt4zKvQ/8Ll3aVWlbx4sRQs7QuB+zMVHs4GLpP0E63LvNXyD3Bq3HfADDfpi0BhYL+NWTdiKG+GAYBKUdGvPI90FFt0cySoJgO5f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Aug 2024 07:29:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16753

Hello Ichikawa-san,

I was just looking at CVE-2023-35827 in more detail.
According to our tracking[0], the issue is already fixed in mainline and CI=
P 5.10/6.1, but not in the older versions.

For some of the CIP versions there is an "ignore" for this CVE labelled "No=
 CIP member enables Renesas Ethernet AVB driver".
However, looking at the cip-kernel-config repo[1] all the Renesas configura=
tions enable CONFIG_RAVB.

Do you know why this "ignore" was added[2] for this CVE?
Note that I haven't checked any others.


[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/blob/master/=
issues/CVE-2023-35827.yml
[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
[2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/commit/0042a=
bd91f2dd701c89c5a0bf681268df8a5c5bb

Thanks, Chris

