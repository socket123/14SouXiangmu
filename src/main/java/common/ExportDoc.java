package common;

import goja.QRCode;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import com.vrv.utils.MD5Util;

public class ExportDoc {
    /**
     * @Description: 将网页内容导出为word
     * @param @param file
     * @param @throws DocumentException
     * @param @throws IOException 设定文件
     * @return void 返回类型
     * @throws
     */
    public static String exportDoc() throws DocumentException, IOException {

        // 设置纸张大小

        Document document = new Document(PageSize.A4);

        // 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中
        // ByteArrayOutputStream baos = new ByteArrayOutputStream();

        File file = new File("D://report.doc");

        RtfWriter2.getInstance(document, new FileOutputStream(file));

        document.open();

        // 设置中文字体

        BaseFont bfChinese = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI,
                BaseFont.NOT_EMBEDDED);

        // 标题字体风格

        Font titleFont = new Font(bfChinese, 12, Font.BOLD);

        // // 正文字体风格
        //
        Font contextFont = new Font(bfChinese, 18, Font.BOLD);

        Paragraph title = new Paragraph("物料转移单", contextFont);
        Paragraph title1 = new Paragraph("NO:2321321321", new Font(bfChinese, 12, Font.NORMAL));
        //
        // 设置标题格式对齐方式

        title.setAlignment(Element.ALIGN_CENTER);

        // title.setFont(titleFont);

        document.add(title);
        document.add(title1);

        String contextString = "iText是一个能够快速产生PDF文件的java类库。"

        + " \n"

        + "";

        Paragraph context = new Paragraph(contextString);

        // 正文格式左对齐

        context.setAlignment(Element.ALIGN_LEFT);

        // context.setFont(contextFont);

        // 离上一段落（标题）空的行数

        context.setSpacingBefore(5);

        // 设置第一行空的列数

        context.setFirstLineIndent(20);

        document.add(context);
        //
        // // 利用类FontFactory结合Font和Color可以设置各种各样字体样式
        //
        // Paragraph underline = new Paragraph("下划线的实现", FontFactory.getFont(
        // FontFactory.HELVETICA_BOLDOBLIQUE, 18, Font.UNDERLINE,
        // new Color(0, 0, 255)));
        //
        // document.add(underline);
        //

        // // 添加图片 Image.getInstance即可以放路径又可以放二进制字节流
        //
        QRCode.create("ssss").toFile("D:\\a.png");
        Image img = Image.getInstance("D:\\a.png");

        img.setAbsolutePosition(0, 0);

        img.setAlignment(Image.LEFT);// 设置图片显示位置

        //
        img.scaleAbsolute(60, 60);// 直接设定显示尺寸
        //
        // // img.scalePercent(50);//表示显示的大小为原尺寸的50%
        //
        // // img.scalePercent(25, 12);//图像高宽的显示比例
        //
        // // img.setRotation(30);//图像旋转一定角度
        //
        //创建表头

        Cell cell1 = new Cell(new Paragraph("编号"));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell1.setVerticalAlignment(Element.ALIGN_CENTER);
        cell1.setHeader(true);
        cell1.setBackgroundColor(Color.RED);

        Cell cell2 = new Cell(new Paragraph("姓名"));
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell2.setVerticalAlignment(Element.ALIGN_CENTER);
        cell2.setHeader(true);
        cell2.setBackgroundColor(Color.RED);

        Cell cell3 = new Cell(new Paragraph("性别"));
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell3.setVerticalAlignment(Element.ALIGN_CENTER);
        cell3.setHeader(true);
        cell3.setBackgroundColor(Color.RED);

        Cell cell4 = new Cell(new Paragraph("备注"));
        cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell4.setVerticalAlignment(Element.ALIGN_CENTER);
        cell4.setHeader(true);
        cell4.setBackgroundColor(Color.RED);

        //创建一个四列的表格
        Table table = new Table(4);
        //设置边框
        table.setBorder(1);
        table.addCell(cell1);
        table.addCell(cell2);
        table.addCell(cell3);
        table.addCell(cell4);
        //添加此代码后每页都会显示表头
        table.endHeaders();

        document.add(img);
        document.add(table);

        document.close();

        // 得到输入流
        // wordFile = new ByteArrayInputStream(baos.toByteArray());
        // baos.close();
        return "";

    }

    //pdf文档中文字符处理
    public static Font ChineseFont() {
        BaseFont baseFont = null;
        try {
            baseFont = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", true);
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Font chineseFont = new Font(baseFont, 8, Font.NORMAL, Color.BLUE);
        return chineseFont;
    }

    public static void main(String[] args) throws DocumentException, IOException {
        //exportDoc();
        System.out.println(MD5Util.getMD5Code("123456"));
    }
}
