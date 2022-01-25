Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22CC433EF
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 14:08:33 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.138])
 by mx.groups.io with SMTP id smtpd.web12.7492.1643119711293761241
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Jan 2022 06:08:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=VmWUbDkj;
 spf=pass (domain: renesas.com, ip: 40.107.113.138,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQNpNEZnC0BRgDf0PCfsTltUaMgYUqfFed+KWgXvngRYMu5WhWGlt9vw3bf8a6zmemCRNjibkr6BHrYBRbKP4b9E+pHamdOC5NWw+Es51i86509vtOLNGZPaRslSKofY/mOucJZag+chHyypAzu2tY5RWqL2oPgV3uONNzq8IP/dCyMXdoelWUwQ7ulArWx5CzyLXEfAtgqic4jY3juHRuZ9goV5OKERa7bm2Wiga8iop089CVSRuI5MK9ri2sXCpfKZEQJCN1iNWDaUjqvnes7dZR5/dCG99PcAICiYGIicwq9JxxUPzGRIUPnREIqTsL34eJgEorLxKk8Rx84l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bebanph6HGPtUtL6X67AjHypbA1qJL7sc991onV+VaQ=;
 b=a7J7UEUdPvMB8KA4TMQQJLWD6dBgxZKV9pkYNqZ7hjKU/ASRJwOa+3rZdTVmXthH1zCVuNCNwjK8tYTglNFONh/byVhx+E3QDyWZbljbDCK6gOP8YJEdTN3ZA9TNxpHMhaKyuYjQIma34etGjOoCkheW60exW7knWpOy3tHJ/Gcq8xvV9y8yACQgLzssItSfVTFZNtHzbpGAEp7ZMLFqFiVQ33RVxL7NxWWx9zPi3x5RvIgMHIlhvORdugZV+dLCQk+qmfq8Ffl49NV0A+SqtIpOSN7iiylkKQrqRCnqWfb14FNgOB60Yq1qmK6EXk1KwgGKmy+CrbnaFheONe4xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bebanph6HGPtUtL6X67AjHypbA1qJL7sc991onV+VaQ=;
 b=VmWUbDkjA/J4nHPcX8yme6TPYQf1frA7/OfLig655nGJAJkn9qKvb1NDBEk562C5KQg92wITPornT1pFzn6ldxjil+Gq2up9HGeEAUkAzFC9Ec8CDsjlKmzSt4ngVQgG66akresXzDdCeruAZNdU+NCiDEofFay+MBlL4DHN2J8=
Received: from TYCPR01MB6868.jpnprd01.prod.outlook.com (2603:1096:400:b7::5)
 by TYCPR01MB8535.jpnprd01.prod.outlook.com (2603:1096:400:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 14:08:27 +0000
Received: from TYCPR01MB6868.jpnprd01.prod.outlook.com
 ([fe80::943b:38ac:d793:9ac5]) by TYCPR01MB6868.jpnprd01.prod.outlook.com
 ([fe80::943b:38ac:d793:9ac5%7]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 14:08:27 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Scheduled down time for lab-cip-renesas
Thread-Topic: Scheduled down time for lab-cip-renesas
Thread-Index: AdgR9OTm4Y4p/rw8R2GFjY7htxfdxg==
Date: Tue, 25 Jan 2022 14:08:27 +0000
Message-ID: 
 <TYCPR01MB6868D9F5EAEB6BC529547A87B75F9@TYCPR01MB6868.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a560627-1461-44ab-0834-08d9e00c288d
x-ms-traffictypediagnostic: TYCPR01MB8535:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB85352F08AF15C64A11BC0EECB75F9@TYCPR01MB8535.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wLCLfuiN7p0AIxlVWehS04pVK71+/Z1U5BYoQooy5GoX+dGgyb2y7kjiWvaDMH877FYE1OQ7zo9pNrrdcv6ByMQ1uI7ctPXDQITsvT3r9hzQw8Xjf6PqBlsMubc+2ub+NCHWPBhv8XSKVKCthgejPRQEWDCRJQLBKekuj4i3lcq7QV5RjgOiX1HqxXjK+bfHOBoXFITVu1Qpn5qxWNj85w0sOYLGcYZ967jbKU9uXK3qb8gDAAa8ncKEZZhskUgeruKLilIC2qZzkvP4llS01/1z639FEkyjmKSQzq7nw2W8MRZ8rcrkRPDpHyOReo6EKdnXdkMFBnBiMlRrpe0h1Tg9xNzhk7e1p50sEYViYxSj7EtXiZ/5LKb2Rk5QCW97mOy+JVkHZ9yjzyiuPbLD9d9/XAcl7PaeJrm/VdpfdvSbROFYtOSugdA/C1wBkZ3tpko4gLXUHTW9zCJ5D4xRMpG3PBZYIhphQ6hgpq7oHOrHSxaa0nVrqdolWTW1PvDQYcqrBYbgNb61Iw+TGgDmAzZ/QW/RvmNUdb9TOhWXfg7Z9xjwqDnRw0kL2AbvuGGyEkgPZtx4av5OQ8zGdi1Jyu411SsSNHwIqNR4qGiyfNixFGwjYkUjEQUF6XyPSeXrBP1Z7PhlSyUDPlq4TRO86gNYmjfnvGavcAHpEzNUf/RkZ1dq8O9hJZNiGgoaAagHlQt3OBX74cV8XftviV2DIw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6868.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(26005)(66476007)(33656002)(5660300002)(76116006)(9686003)(52536014)(71200400001)(86362001)(6916009)(2906002)(66946007)(38070700005)(66556008)(64756008)(316002)(6506007)(122000001)(66446008)(7696005)(38100700002)(8676002)(186003)(558084003)(8936002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?l5gkN8TkmHRk59GA4wHVUyI3iwK6xzSSiXPReWvjq6D5j31P2HdAo2DSjH?=
 =?iso-8859-1?Q?iCUQK2wqtrTZ3zZJ2rF/4GUJW0M+f1zZdekKv/XhuLd6BTaLs+Hwd0gXlv?=
 =?iso-8859-1?Q?T4OzP8eHxxYQ7Z55/WJrLHgo1ulRgjDVidKbYDbjGprm1BJYpLH4Iz3FaH?=
 =?iso-8859-1?Q?ouqCb38QrR3Ohz8kA4ThFnijJFqY2xRZsjZhofTfBilXmI7+EDb0tEvVpc?=
 =?iso-8859-1?Q?J/QLe3ZBIaIWv/sYLHSg3skE32ITIXFTdhTC/nwob3wchnCOg9VZqps0oF?=
 =?iso-8859-1?Q?vwUz/eJ22xWjU6g2PoZoWDiLYW99hglddJbXF87F37qsBR+Jt7nbGewNeK?=
 =?iso-8859-1?Q?+4ogRAGm75G1xD4tTI/nyx20Zhdkv9DGNB67F+MC9VGHrGPxEPJPSVFfcI?=
 =?iso-8859-1?Q?R9E5b8MlKV1Yw8PDjHKp7QB/DUUzVwtCPQuq3cCQ+RVrKcwEpCSPWP+v0y?=
 =?iso-8859-1?Q?Rq9p8k7rf6POlv2BawfFa7fv5TaOpgeBtTfYzC+DH0ucbqIpuMCULX9NAW?=
 =?iso-8859-1?Q?jim7CrG9Yd/yJ1Bc13vnHKtcTUrebSDjbVMJiL9tufac21A2oqflK15odC?=
 =?iso-8859-1?Q?Y5MeihUlF6+QKZn39avB77E5KNRzUFpR3XH7L6DM9LiPu60J3oE1vMIhYF?=
 =?iso-8859-1?Q?wsQRD3hzOLS9NffNQr8fnuhcDuadfFvfYGbaElXFKfBWj93k9Q6vEFdf8k?=
 =?iso-8859-1?Q?PiN1+GkdU6GlV8LbUYSpePjn0/660b/5GXwlNy+H9DGga8kLXrzs//gS2X?=
 =?iso-8859-1?Q?k5AsFYokEY5lFVLsNQffRmL5SOGSA4svSCfvgwPJvcfklIzI/gRx9I1r1c?=
 =?iso-8859-1?Q?bAp1YmAGzwoQTfPbOq5Z9FpU3jtUbGL6p0gAXFmKTVT7uk3xB9s/7FAuFC?=
 =?iso-8859-1?Q?hAA51zid8NdkiigsruVUiSzvYFirVVgPskJ3LN777dTNpH8PJDU7b7wPo4?=
 =?iso-8859-1?Q?n18SajUxidx+tyISX9Uv/QZsg00yOiY5cwOi+jcDOXJHCMcmarpRryZu0z?=
 =?iso-8859-1?Q?J8+eJzHcuLYErX6HoxAC6yiauWG0xYf4G5tXGVsdd36uIW1K86fpkkhHrP?=
 =?iso-8859-1?Q?o/ZxWOoBwsLf/+5jbwGxz/VyVw3fRYeCiy4xE9A5gSwnyeXAMSPgCzkwJ+?=
 =?iso-8859-1?Q?sRgLfaL+wjLEKHyPCaN1f2bi8XKIdhEy3mIdhCZ1mLg/OCIJIeyKo/wqeR?=
 =?iso-8859-1?Q?+wYDaaX/vzFoUIR/uCY9gFEBTQI48TnHmtoctHEkAKChG/cXc9hnr5GjvQ?=
 =?iso-8859-1?Q?eYip+6eiLcRS0dd7t+wLcYLrE2+9dCpWmSEukGhFhKkPySLQb92adWTWay?=
 =?iso-8859-1?Q?x9Nwzm29luFOcXOsUpnijT5ngDCcMJTpNxO+FC4/59JSJ7eLrVX9t6g/rH?=
 =?iso-8859-1?Q?Kxry3Bz7rnbvZqxH0qp2mEQNZ03o+zUk3uCKCuTebBWk6wsNxx9AvDGzUt?=
 =?iso-8859-1?Q?BC0AfVQGq9b3IOKanjzV+tPun7RPhMqrIpHEFQ9vGEz3AByWmjskMPYq5d?=
 =?iso-8859-1?Q?i+7iDz61J7e44QeCw3z8sQJUW7HQCCx1fkIyVCQlh8IDUW4/FUiBhGlr2A?=
 =?iso-8859-1?Q?BbUcGmdU4WbmteLmUbH9tuwwFdJ8AgjgBuK1Bm0r7Ivz2ZorWExQm1iPoQ?=
 =?iso-8859-1?Q?hn0IFu+bwTmZHrlndJjqQ1HPihqx7428BMEl9fCeO8Lua84365ZZydx5Og?=
 =?iso-8859-1?Q?24lhhEbU8pgqoFZ+4uBMQT/i2N/nouHMgiE+jRd0jwQZuWUaqkUOQQ5I9c?=
 =?iso-8859-1?Q?jtQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6868.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8a560627-1461-44ab-0834-08d9e00c288d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 14:08:27.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 b0Hx26sdA+htNmvbLTcOETkennqFiG2v3uq6dla+NDOPjPn8vcIWY9WIiciHhaq+Y0xL0CWU34Mrm3S0Be952D8hu/KvpWCLyYY33AgmMLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8535
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jan 2022 14:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7480

Hello all,

Just a quick note to say that lab-cip-renesas will be offline tomorrow (Wed=
 26th) for a couple of hours, starting from about 1130 UTC.

Kind regards, Chris


