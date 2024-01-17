package cn.edu.szu.csse;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
/**
*@author ZhengYuTiing
*@date 创建时间：2022年11月6日 上午9:37:58
*/
public class SheepAndSheep extends JPanel implements MouseListener {
	static JPanel pane2=new JPanel(new FlowLayout());
	static int grassNum=0;
	static int carrotNum=0;
	static int cornNum=0;
	static int finishsum=0;
	
	static LinkedList<JLabel>  list=new LinkedList<JLabel>();
	
	static JFrame frame=new JFrame("羊了个羊");
	static ImageIcon grassIcon = new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass1.jpg");
	static ImageIcon cornIcon = new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn1.jpg");
	static ImageIcon carrotIcon = new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot1.jpg");
	static ImageIcon backgroung= new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\background.jpg");
	static ImageIcon down= new ImageIcon("D:\\大二\\大二上\\Java程序设计语言\\pictures\\down.jpg");
	static JLabel bgl=new JLabel(backgroung);
	static JLabel bg2=new JLabel(down);
	
	SheepAndSheep(){
		MyMouseAdapter listenner=new MyMouseAdapter();
		int grassnum=0;
		int cornnum=0;
		int carrotnum=0;
		this.setLayout(new GridLayout(6,3));
		ImageIcon a[]=new ImageIcon[3];
		a[0]=grassIcon;
		a[1]=cornIcon;
		a[2]=carrotIcon;
		JLabel b[]=new JLabel[18];
		Random r = new Random();
		for(int i=0;i<18;i++) {
			int j=r.nextInt(3);
			if(j==0)grassnum++;
			if(j==1) cornnum++;
			if(j==2) carrotnum++;
			if(grassnum>6) {
				grassnum--;
				i--;
				continue;
			}
			if(cornnum>6) {
				cornnum--;
				i--;
				continue;
			}
			if(carrotnum>6) {
				carrotnum--;
				i--;
				continue;
			}
			b[i]=new JLabel(a[j]);
			b[i].addMouseListener(listenner);
			this.add(b[i]);
		}
	}
	public class MyMouseAdapter extends MouseAdapter{
		
		public void mouseClicked(MouseEvent e) {// 单击鼠标时执行的操作
			finishsum++;
			JLabel a=new JLabel();
			a=(JLabel) e.getSource();
			String str=a.getIcon().toString();	
			a.setVisible(false);
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\grass1.jpg") {
				 grassNum++;
				 if(grassNum==3) {
					 grassNum=0;
					 remove(grassIcon);
				 }
				 else {
					 add(grassIcon);
				 }
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\corn1.jpg") {
				 cornNum++;
				 if(cornNum==3) {
					 cornNum=0;
					 remove(cornIcon);
				 }
				 else {
					 add(cornIcon);
				 }
			}
			if(str=="D:\\大二\\大二上\\Java程序设计语言\\pictures\\carrot1.jpg") {
				carrotNum++;
				if(carrotNum==3) {
					carrotNum=0;
					 remove(carrotIcon);
				 }
				else {
					 add(carrotIcon);
				 }
			}
			
			pane2.removeAll();
			for(int i=0;i<list.size();i++){
				pane2.add(list.get(i));
			}
			pane2.repaint();
			
			if(finishsum==18) {
				JOptionPane.showConfirmDialog(frame,"恭喜你！！！！通过第一关");
			}
		}
		
	}
	public void add(ImageIcon icon) {
		JLabel a=new JLabel(icon);
		int x=list.size();
		for(int i=0;i<list.size();i++){
			if(list.get(i).getIcon()==icon) {
				x=i;
				break;
			}
		}
		list.add(x,a);
	}
	public void remove(ImageIcon icon) {
		for(int i=0;i<list.size();i++){
			if(list.get(i).getIcon()==icon) {
				list.remove(i);
				i--;
			}
		}
	}
	private static void createAndShowGUI() {		
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	
		
		bgl.setSize(backgroung.getIconWidth(),backgroung.getIconHeight());	
		
		frame.getLayeredPane().add(bgl,new Integer(Integer.MIN_VALUE));
		//frame.getLayeredPane().add(bg2,new Integer(Integer.MIN_VALUE+1));
		bgl.setBounds(0, 0, backgroung.getIconWidth(), backgroung.getIconHeight());
		//bg2.setBounds(backgroung.getIconHeight(), backgroung.getIconWidth(), backgroung.getIconWidth(), backgroung.getIconHeight());
		Container contain = frame.getContentPane();
		((JPanel) contain).setOpaque(false);	
		frame.setSize(500, 600);
		SheepAndSheep pane=new SheepAndSheep();
		pane.setOpaque(false);	
		pane2.setOpaque(false);
		frame.add(pane,BorderLayout.NORTH);
		frame.add(pane2,BorderLayout.SOUTH);
		frame.setVisible(true);
		
	}
	public static void main(String [] args) {
	javax.swing.SwingUtilities.invokeLater(new Runnable() {
		public void run() {
			createAndShowGUI();
		}
	});
}
}
