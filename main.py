from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label

class MonApp(App):
    def build(self):
        layout = BoxLayout(orientation='vertical')
        self.label = Label(text="Bonjour !")
        bouton = Button(text="Clique-moi")
        bouton.bind(on_press=self.dire_bonjour)
        layout.add_widget(self.label)
        layout.add_widget(bouton)
        return layout

    def dire_bonjour(self, instance):
        self.label.text = "Ça marche sur Android !"

if __name__ == '__main__':
    MonApp().run()
    
