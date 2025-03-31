Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E74AC3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web10.49046.1743417947150721213
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WDL1nDDS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haMbxEqb08+WgHzj+ctJ0A0fn/CIN5pXBMAtqtPqwXC+xM/cOarehFhSRd8xuN86BqvMbm45w0vtnMJVMIAWVEB7rT4uvC56jMQtDAptHT4SpMT7TOoYkfKI/R4obKOIKrkTMCO0vxiA+WWrThzfPD55X0Ubhoiw1QUdacOasf/GfOECxcoZneHSRU/B561bqLwDIz0ZIHejsQ4VKfNg4Ps86+pggPwm48988FDcUCBkBHFxIGP1YRbC+H0WUquYuOIgzXjBMKhj6B814DnG6EkM25ZePV9ME6gkaUTZvaEqenqVHTk07ZaUVfrP3peTxpxw6WLigsUN2NqBdqch+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgIeyCtMHquBzi+grN32qhwTg9fdS94ikZkkgn810M8=;
 b=V+bqJtRKXynBey4GN2++s2fKJDRjP0Gg0ARpVt2eSRjVlqyPWD51S7SRWITQ3kxZQc0m15enAg/lTVmnzizS360C9+UlIEfoSTbcEeI9UiVNZfSANfbfPoZ+coxaXDBEcT1T8HamzzBVwpwJgH0q9jhFUyqvaSUqir2CvfV4ve8EGXRhMNqWB5qXtS423lA/opTrIwtJtjAaVH5Xj3KF1r0LMEUs1biMnezKVUmln7MVwd5qAIJz3B+piy5QYkEBGu2uXm8oC8F2pRjrWzswIkfb9urhfbQzl5NcAPBKKn+rEboXg5S5mopazdOAb9FMLLaeEWyHq6DzhTSmPfHRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgIeyCtMHquBzi+grN32qhwTg9fdS94ikZkkgn810M8=;
 b=WDL1nDDSrmJYhzQVgqdxThyMWXbt+Fn0PseSrEiCgBLX9rr3erbuMWKqDsUgF20LfVL64yddVN9JstewIYCExGdLXUyaFyxUT1m8hylDMSJDhWR+woT4if8ukUIZ1Ta0RS1U3ipy81MGXUBlynx7YVfxT7QUGZFxPxEzokBmA6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/43] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open drain properties
Date: Mon, 31 Mar 2025 12:44:36 +0200
Message-ID: <20250331104514.79090-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5426905a-1965-4def-f190-08dd70413190
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KUT2oz9faYdtsig6dgJu1pXuZXd0Crlr70rx3OCXLG1wG2itlaCBq/C2ZSYy?=
 =?us-ascii?Q?qdeG8IT4nXo4zIYZ1QQVC+AYqHl0KAeYgaZrSL75Zn7L7LZzpXx3t6T9j23G?=
 =?us-ascii?Q?NDs2cXbcjc7T1qrzjJTstdbXuSeh/C6HSD8ErDvjCwT2Uj5wf4h5MX+BK9LF?=
 =?us-ascii?Q?c9gBb0tcmmEQyNiSWa+nC+pYWHOEjqhyX7bJNBSvIEaUCiKiRvSLwJuXcOFq?=
 =?us-ascii?Q?E67hHxItf32QK38r5C8ovbU0FkaInz+1prw2FiC/gru9QKbMDap108yDltl2?=
 =?us-ascii?Q?K1ZLxs1A/AgS8nGSi2SsGTiZGZYkez2wFwBRLHiA8Y5Bse4igMuhq4NSO8Rn?=
 =?us-ascii?Q?xYO0eE0X3sYVTe7le9rD2A0uknr7ZbPeiHWr7ljNr3jXAGrI6DIezh5O22V3?=
 =?us-ascii?Q?+0eUcJc3z92beASVI75uXg7QSn77M9dFWYSZblRmG2HkNzTrwO83tdN2lrEk?=
 =?us-ascii?Q?Gb9VvkskmrJKBgsvs3JSGgVk2rKuMnkJ9ZrZr1RWptEKYlzKz6Xzj5W4RRdI?=
 =?us-ascii?Q?w440zUzyeqTcTXK9XQlKVyLm0lCKUb4XAGWABoQuLdPClOKCnnX1gvGIhlwf?=
 =?us-ascii?Q?PV0s7F8E8Je3IvJmZRHxaZy+czIQt11UvkCNfZqYcRRLmenw49+htFnqX6EU?=
 =?us-ascii?Q?xuVSQcrFz5pVpSlP0fH9M0KVEoFMOccGZDR34UgFVCRg+bgOgfwGTNwZPw/Z?=
 =?us-ascii?Q?edBF2Jhpv1GUUAdjdXrHiGjqWHlUdlug0Eto3z/Fry9e7aWUWQe7Y967PNPF?=
 =?us-ascii?Q?hAMMoxwrU6RsYCpElHq3wxhoYgJML/1mtQgE1kQdQMbef7ot2hahMehROQmk?=
 =?us-ascii?Q?/xTYCB8l/vUDEwRCp4lnF+levBNkM8YDTBzDFNQemLXIoFoxPNzvyF92gg0v?=
 =?us-ascii?Q?Vhe+5lO9o0Y+JpQhmnCaemPvAb0of+1zPn5a+Ufpn7vPa8GPHLR7UBPZyiw0?=
 =?us-ascii?Q?Qu4fhPU9BIuw6g0woDz3G6E+FAXSOj8f3uYjrj+9F9X51eSptvNKE5D3/Liy?=
 =?us-ascii?Q?od8L4S280ASFT6Q9H7DsoZ4SQtmmO4sPf9ZewD0JD0Mf3/+u8FMHzxBGQFwl?=
 =?us-ascii?Q?pTn3GrC1pLcjEDcfk9CmDaVPoMvsw0TYJoqvKvXNUa8P47S/VMDbUpmupVYI?=
 =?us-ascii?Q?EwKfYyisWXMIAPVilfmM975rxBxIQvjwWBMyr5AlOWo42wDcVDw61fyv0CvZ?=
 =?us-ascii?Q?KJ6M5HeYeJIZdxnfKJRHae95b/s3mFaBd0AKCtYN6Iv9Y8e5ZbewBCn++dSX?=
 =?us-ascii?Q?+FYcJAOahcjttLxpdasxnk/BeRsZpCE3kbeXFeSRzvoENhZxixKl9TVp63/p?=
 =?us-ascii?Q?XaH/RBLFxgN7bD0pG03hbKSzikUgjp1zPGLOnuGvLeS3DacBHETSbOTkcRzd?=
 =?us-ascii?Q?cduiOciYe/gOpFyKTOsKkJIidyh9y0aby0f0fvxR3MdhFncPcFa3owbZ8FU3?=
 =?us-ascii?Q?f5egGFpTnR/UZIgviLXdrIGOJ5/T/p95?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WFT0d/UuVbcZhRtb/mBXDB0pcsyYtg56FfP+D6Hjvsdgm7UH5D8eK3S2OmE/?=
 =?us-ascii?Q?ndjFaHHiXoMtuKU1sePZirf+nemQesTJU1adS7ZJ0A1G+6UroD4ddx1cHlml?=
 =?us-ascii?Q?TAlgOr84qUTPt0AK2sLMNCoo0cKI8GO+ExBcwknsF9dkgIaybESv7459u9VE?=
 =?us-ascii?Q?nzV3ndmEg2QP/M7O90FzD+3btCC79Zdz50GSUCY5Nd62EnX8yhKuXxlZdBeH?=
 =?us-ascii?Q?LM07y/pvr91dnMm1fE4RdggJquJkx9S7zbRJfhZtLeR8pijG+qZ5GNMcGuY0?=
 =?us-ascii?Q?+pZelWl0QEiCDkvOk9slbajwAXnZSP+ulYZrffhAIYJq8RBiB3wJ1/F6XrxQ?=
 =?us-ascii?Q?Qu2GuNp8ut2oCQWA4A46rD0jETDrKz2cBsknnoj29OId6a05GO1uK3fwPPdZ?=
 =?us-ascii?Q?nLQnwCibWdkQQDioNoDZNDDWyb90tfIcQrnMUimABrH/AiZNRDu7JMi6RbSf?=
 =?us-ascii?Q?u4vZq4FXe1uqCyZKv9XZ/6ZMHAwmObug0ed0Dv2z+AzZE99rPfqF1FvmwtYx?=
 =?us-ascii?Q?gcWxQnnNnoFzivlUlLFL+zKPGh8A1XpnenkPVubwTP4zgdZXSCDzuoo/4DjP?=
 =?us-ascii?Q?yl62n+/nn9iApC9OwTOt9t+1CyoF+6f9Hsod8sc0/F31js+YgdXTMKPSlEhv?=
 =?us-ascii?Q?qz7I8tYsGb1W16b3u5SUPDSW9o43i6cQtkbpvIpRuuiXvVrHVu+WCmQRsRjH?=
 =?us-ascii?Q?t4KB//tjMLU4kJNoa0nIVSswzrlZluRwDVirsqxm/DJnXk0j9TAo8Gh6a7ud?=
 =?us-ascii?Q?6+4JuqyVP6pY0GvOA0Sw8RoBs/9xa9W/r/LrVzwaZ5PQbLyBhA2/8ZghkuD4?=
 =?us-ascii?Q?PpA8o46CYZsxgNA6lwrMcQENuWCg26hiK2R7TfN+Bv+CKMNNLD9dhcycQiYO?=
 =?us-ascii?Q?ztxROO1yTeD7nvUeim3FDmgwcUNDOkeHCJwQctJ2YHSxdO6GJ56GrS/ynwX7?=
 =?us-ascii?Q?45Po9CuajoyAOxwVUdgr9iSRsHgMssuzmWw0+zwPErKaMd3er5Gxd9qSq/6m?=
 =?us-ascii?Q?98blZbj+NF3t6WIWYcpyuAL9zTScv7ocDN/ujprqqIjKjWNXpQlilraJCmy+?=
 =?us-ascii?Q?bCV5EjahXZfRJ3MN2L+aSVMA7a7JWyQEIMqpQ36bStqHZPAEshRnMah8ohvD?=
 =?us-ascii?Q?4O6BbZy6ZgvnGWdXE946l3LFOKejuG9S+Np8vgct5KIVJTMdLS0I9MUNw0Rv?=
 =?us-ascii?Q?PHoTvMN8o3eoUObK44QS27j9u3tNjIPZVGKC/FKmpyHqyb74OTm610pvGSsF?=
 =?us-ascii?Q?FpZ5LIHQSUcDWoP3kLDuAZ/9xHUaJ5vf/9bohWvqQxLGNa/ROtadrFLeC4+Y?=
 =?us-ascii?Q?I+W1+F4ILM4qPG+xw2+ZYkUFOYlqPF1NMojKZAowb5OoU9V52LQZ7yyc+B25?=
 =?us-ascii?Q?9oGJLLTNxOPH6uy4L6N27cXNmf2p1/8tsMtil5FDPSa2XahATbXG21ojJj/r?=
 =?us-ascii?Q?zhI3Zl7BJhyCi3mcBNQSy+4OqD5j0iG81r/27LTHG2aXtOleR2+9PR/X3ygS?=
 =?us-ascii?Q?JmXZ0ahrDlvlg1zGv4IdoJ861GIeBn2KnU6PpiHJxjYro0NZoA7TRHYjM7rl?=
 =?us-ascii?Q?JVJvp3RJ+X141k75AZHp9uiBF9eUXPBj8C/Gdvbc3ofXc67D+nkRobBT6Utj?=
 =?us-ascii?Q?Mqt11aV+qASTwGeuKKP976Y=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426905a-1965-4def-f190-08dd70413190
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:46.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDPOONzchWFRw7KpBhYd+ffriY5qdwNXmotkWzcEl4XRicSOxlSyHD4v9CbVdQySBgjE7H2g2kzsdIHvsfSGN2SGAHhfmB2+MEEYBVm1CfnbWRkWc0hx3yuaz5Onkli5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18393

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f07e2b681edd8d8ed25048b958fdcfb55abaf487 upstream.

On the RZ/V2H(P) SoC one can configure the 'input-schmitt-{enable,disable}'=
,
'drive-open-drain' and 'drive-push-pull' of multiplexed pins. Update the
binding documentation to include these properties.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/20241004123658.764557-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 7d7e66eaabf19..1a16fc06c96a7 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -119,6 +119,10 @@ additionalProperties:
         bias-disable: true
         bias-pull-down: true
         bias-pull-up: true
+        input-schmitt-enable: true
+        input-schmitt-disable: true
+        drive-open-drain: true
+        drive-push-pull: true
         renesas,output-impedance:
           description:
             Output impedance for pins on the RZ/V2H(P) SoC. The value prov=
ided by this
--=20
2.43.0


