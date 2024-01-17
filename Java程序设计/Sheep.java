package SheepSheepv2;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import cn.edu.szu.csse.SheepAndSheep;
import cn.edu.szu.csse.SheepAndSheep.MyMouseAdapter;

import java.util.*;
/**
*@author ZhengYuTiing
*@date 创建时间：2023年2月13日 下午11:03:08
*/
public class Sheep {
	static JPanel pane2=new JPanel(new FlowLayout());
	static LinkedList<JLabel>  list=new LinkedList<JLabel>();
	static JFrame frame=new JFrame("羊了个羊V2.0");
	static ImageIcon image[]=new ImageIcon[5];
	static JLabel card[]=new JLabel[70];
	static int x=0;
	static int y=0;
	static int num[]=new int[5];
	static Icon last=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass.jpg");
	private static void createAndShowGUI() {		
		
		frame.setSize(500, 700);
		frame.setLayout (null);
		//(JFrame).getLayeredPane().setLayout(null);
		
		Random r = new Random();
		image[0]=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass.jpg");
		image[1]=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot.jpg");
		image[2]=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn.jpg");
		image[3]=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\water.jpg");
		image[4]=new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\fire.jpg");
		
		for(int i=0;i<5;i++) {
			num[i]=0;
		}
		for( int i=1;i<=61;i++) {
			JLabel label = new JLabel();
			int j=r.nextInt(5);
			label.setIcon(image[j]);
			card[i]=label;
			card[i].addMouseListener(new MyMouseAdapter());
		
		}
		int p=1;
		for(int i=75;i<=275;i=i+50) {
			for(int j=75;j<=275;j=j+50) {
				frame.add(card[p]);
				card[p].setBounds(i, j, 50, 50);
				p++;
			}
		}
		for(int i=50;i<=300;i=i+50) {
			for(int j=50;j<=300;j=j+50) {
				frame.add(card[p]);
				card[p].setBounds(i, j, 50, 50);
				p++;
			}
		}
		JLabel label1 = new JLabel(new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\shangyi.jpg"));
		JLabel label2 = new JLabel(new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\chexiao.jpg"));
		JLabel label3 = new JLabel(new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\daluan.jpg"));
		label1.addMouseListener(new MyMouseAdapter());
		label2.addMouseListener(new MyMouseAdapter());
		label3.addMouseListener(new MyMouseAdapter());
		frame.add(label1);
		frame.add(label2);
		frame.add(label3);
		label1.setBounds(100, 500, 58, 45);
		label2.setBounds(200, 500, 58, 45);
		label3.setBounds(300, 500, 58, 45);
		frame.add(pane2);
		pane2.setBounds(600, 50, 400,50);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	
		frame.setVisible(true);
	}
	public static void main(String [] args) {
	javax.swing.SwingUtilities.invokeLater(new Runnable() {
		public void run() {
			createAndShowGUI();
		}
	});
}
	static void add(ImageIcon icon) {
		JLabel a=new JLabel(icon);
		int x=list.size();
		for(int i=0;i<list.size();i++){
			if(list.get(i).getIcon()==icon) {
				x=i;
				break;
			}
		}
		list.add(x,a);
		int result=0;
		if(list.size()>6) {
			JOptionPane.showConfirmDialog(frame,"游戏失败,是否复活?");
			if(result == JOptionPane.OK_OPTION){
				shangyi();
			}
		}
		
	}
	static void remove(ImageIcon icon) {
		for(int i=0;i<list.size();i++) {
			list.get(i).setVisible(false);
		}
		for(int i=0;i<list.size();i++){
			if(list.get(i).getIcon()==icon) {
				list.remove(i);
				i--;
			}
		}
	}
	static void shangyi() {
		for(int i=0;i<list.size();i++) {
			list.get(i).setVisible(false);
		}
		for(int i=0;i<3;i++) {
			JLabel a=new JLabel(list.get(0).getIcon());
			String str=a.getIcon().toString();
			int p=80;
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass.jpg") {
				 p=0;
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot.jpg") {
				 p=1;
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn.jpg") {
				 p=2;
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\water.jpg") {
				 p=3;
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\fire.jpg") {
				 p=4;
			}
			num[p]--;
			list.removeFirst();
			frame.add(a);
			a.setBounds(100+50*i, 400, 50, 50);
			a.addMouseListener(new MyMouseAdapter());
			a.setVisible(true);		
		}
	}
	static void chexiao() {
		for(int i=0;i<list.size();i++) {
			list.get(i).setVisible(false);
		}
		JLabel a=new JLabel(list.get(list.size()-1).getIcon());
		String str=a.getIcon().toString();
		int p=80;
		if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass.jpg") {
			 p=0;
		}
		if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot.jpg") {
			 p=1;
		}
		if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn.jpg") {
			 p=2;
		}
		if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\water.jpg") {
			 p=3;
		}
		if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\fire.jpg") {
			 p=4;
		}
		num[p]--;
		list.removeLast();
		JLabel llast=new JLabel(last);
		frame.add(llast);
		llast.setBounds(x, y, 50, 50);

		llast.setVisible(true);
	}
	static void daluan() {
		Random r = new Random();
		for( int i=1;i<=61;i++) {
			int j=r.nextInt(5);
			card[i].setIcon(image[j]);
			card[i].addMouseListener(new MyMouseAdapter());
		
		}
	}
	static class MyMouseAdapter extends MouseAdapter{
		public void mouseClicked(MouseEvent e) {// 单击鼠标时执行的操作
			
			int p=80;
			JLabel a=new JLabel();
			a=(JLabel) e.getSource();
			String str=a.getIcon().toString();
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\shangyi.jpg") {
				shangyi();
			}
			else if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\chexiao.jpg") {
				chexiao();
			}
			else if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\daluan.jpg") {
				daluan();
			}
			else {
				x=a.getX();
				y=a.getY();
			//	System.out.print(x+" "+y);
				last=a.getIcon();
				if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass.jpg") {
					 p=0;
				}
				if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot.jpg") {
					 p=1;
				}
				if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn.jpg") {
					 p=2;
				}
				if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\water.jpg") {
					 p=3;
				}
				if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\fire.jpg") {
					 p=4;
				}
				a.setVisible(false);
				num[p]++;
				if(num[p]==3) {	
					num[p]=0;
					remove(image[p]);
				}
				else {
					 add(image[p]);
				 }		
			}
			//底部
			for(int i=0,j=50;i<list.size();j=j+50,i++) {
				frame.add(list.get(i));
				list.get(i).setBounds(j, 600, 50, 50);
				list.get(i).setVisible(true);
			}
			System.out.print(list.size());
			
		}	
	}
}

